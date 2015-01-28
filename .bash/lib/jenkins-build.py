#!/usr/bin/env python

# README:
# pip install python-jenkins
#   https://python-jenkins.readthedocs.org/en/latest/example.html
# configure user as your git author name - assumes your .gitconfig is correct
# configure jenkins user as your jenkins username
# configure jenkins api as your jenkins api token, put it in jenkins.key
#   http://jenkins0.dev.returnpath.net/user/<username>/configure
#   Click "Show My Token" button

import urllib
import urllib2
import json
import httplib
import jenkins
import time
import pprint
import sys
import os
import subprocess

#pp = pprint.PrettyPrinter()

if sys.argv[1] == 'prod':
	mode = 'prod'
	mode_text = 'Production'
else:
	mode = 'test'
	mode_text = 'Test'

# jenkins.dev user info
jenkins_user = subprocess.check_output(['whoami']).strip()
jenkins_key  = open(os.path.expanduser('~')+'/.bash/lib/jenkins.key', 'r').read().strip()

# jenkins0.dev user info
jenkins0_user = subprocess.check_output(['whoami']).strip()
jenkins0_key  = open(os.path.expanduser('~')+'/.bash/lib/jenkins0.key', 'r').read().strip()

#
git_user_name = subprocess.check_output(['git', 'config', 'user.name']).strip()

# My open changes for project
master_gerrit_url = 'http://gerrit.dev.returnpath.net/changes/?q=is:merged+project:'+ sys.argv[2]+'&o=CURRENT_REVISION'
master_changes = json.loads(''.join(urllib2.urlopen(master_gerrit_url).readlines()[1:]))

# My open changes for project
my_gerrit_url = 'http://gerrit.dev.returnpath.net/changes/?q=is:open+owner:'+urllib.quote('"%s"' % (git_user_name))+'+project:'+ sys.argv[2]+'&o=CURRENT_REVISION'
my_changes = json.loads(''.join(urllib2.urlopen(my_gerrit_url).readlines()[1:]))

# All open changes for project
all_gerrit_url = 'http://gerrit.dev.returnpath.net/changes/?q=is:open+project:'+ sys.argv[2]+'&o=CURRENT_REVISION'
all_changes = json.loads(''.join(urllib2.urlopen(all_gerrit_url).readlines()[1:]))

build_header = '\n\n'+sys.argv[2]
print (build_header)
print (len(build_header) -1 ) * '='
print 'Preparing to build for the '+mode_text+' environment...'

# Building for test
if mode == 'test':

	count = 0
	commits = {}

	# Build master screen
	code_reviews = ('\nCurrent master:')
	print(code_reviews)
	print (len(code_reviews) -1 ) * '-'
	print('    [%d] %s' % (count, master_changes[0]['subject']))
	commits[count] = {}
	commits[count]['id'] = master_changes[0]['_number']
	commits[count]['refspec'] = 'refs/heads/master'
	count += 1

	# My code reviews screen
	code_reviews = ('\n\nMy open reviews:')
	print(code_reviews)
	print (len(code_reviews) -1 ) * '-'
	for change in my_changes:
		print('    [%d] %s' % (count, change['subject']))
		commits[count] = {}
		commits[count]['id'] = change['_number']
		commits[count]['refspec'] = ('refs/changes/%s/%s/%s' % (str(change['_number'])[-2:], change['_number'], change['revisions'][change['current_revision']]['_number']))
		count += 1

	# All code reviews screen
	code_reviews = ('\n\nOpen reviews for other committers:')
	print(code_reviews)
	print (len(code_reviews) -1 ) * '-'
	for change in all_changes:
		if change['owner']['name'] != git_user_name:
			print('    [%d] (%s) %s' % (count, change['owner']['name'], change['subject']))
			commits[count] = {}
			commits[count]['id'] = change['_number']
			commits[count]['refspec'] = ('refs/changes/%s/%s/%s' % (str(change['_number'])[-2:], change['_number'], change['revisions'][change['current_revision']]['_number']))
			count += 1

	# prompt
	commit_id = raw_input("\n\nWhich commit would you like to build for test? ('q' to quit): ")

	if commit_id == 'q':
		quit()

	# Execute Jenkins build
	else:
		commit = commits[int(commit_id)]

		print('\nStarting Build for Commit %s Revision %s' % (commit['id'], commit['refspec']))

		build_params = {'Action': 'Build_and_Stage_Branch','GERRIT_BRANCH': 'master', 'GERRIT_REFSPEC': commit['refspec']}

		# Figure out which server the project lives on
		#
		# @todo Try to use the Jenkins API to check if the project exists instead
		# of just catching the exception...
		try:
			j = jenkins.Jenkins('http://jenkins0.dev.returnpath.net', jenkins0_user, jenkins0_key)
			job_info = j.get_job_info(sys.argv[2])

		except jenkins.JenkinsException:
			j = jenkins.Jenkins('http://jenkins.dev.returnpath.net', jenkins_user, jenkins_key)
			job_info = j.get_job_info(sys.argv[2])

		# Trigger the build and wait for a success response
		next_build_number = job_info['nextBuildNumber']
		j.build_job(sys.argv[2], build_params)
		building = False
		while building != True:
			sys.stdout.write('.')
			sys.stdout.flush()
			time.sleep(1)

			try:
				build_info = j.get_build_info(sys.argv[2], next_build_number)
				building = build_info['building']

			except:
				pass

		print('\nSuccess! see your build here: \n%s\n\n' % (build_info['url']))

else:
		build_params = {'Action': 'Release','GERRIT_BRANCH': 'master', 'GERRIT_REFSPEC': 'refs/heads/master'}

		try:
			j = jenkins.Jenkins('http://jenkins0.dev.returnpath.net', jenkins0_user, jenkins0_key)
			job_info = j.get_job_info(sys.argv[2])

		except jenkins.JenkinsException:
			j = jenkins.Jenkins('http://jenkins.dev.returnpath.net', jenkins_user, jenkins_key)
			job_info = j.get_job_info(sys.argv[2])

		next_build_number = job_info['nextBuildNumber']
		j.build_job(sys.argv[2], build_params)

		building = False
		while building != True:
			sys.stdout.write('.')
			sys.stdout.flush()
			time.sleep(1)

			try:
				build_info = j.get_build_info(sys.argv[2], next_build_number)
				building = build_info['building']

			except:
				pass

		print('\nSuccess! see your build here: \n%s\n\n' % (build_info['url']))
