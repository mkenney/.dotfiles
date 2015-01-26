#!/usr/bin/env python

# README:
# pip install python-jenkins
#   https://python-jenkins.readthedocs.org/en/latest/example.html
# configure user as your git author name
# configure jenkins user as your jenkins username
# configure jenkins api as your jenkins api token, put it in jenkins.key
#   http://jenkins0.dev.returnpath.net/user/<username>/configure
#   Click "Show My Token" button


import urllib
import urllib2
import json
import httplib
import jenkins
from time import sleep;
import pprint
import sys
import os
import subprocess
from os.path import expanduser
home = os.path.expanduser("~")

user = subprocess.check_output(['git', 'config', 'user.name']).strip()
jenkins_user = subprocess.check_output(['whoami']).strip()
jenkins_api  = open(home + '/.bash/lib/jenkins.key', 'r').read().strip()

gerrit_url = 'http://gerrit.dev.returnpath.net/changes/?q=is:open+owner:'
gerrit_url += urllib.quote('"%s"' % (user))
gerrit_url += '&o=CURRENT_REVISION'

changes = urllib2.urlopen(gerrit_url)
changes = json.loads(''.join(changes.readlines()[1:]))

code_reviews = ('\nCode Review Currently open for %s:' % (user))
print(code_reviews)
print (len(code_reviews) -1 )* '=' + '\n'

count = 1
commits ={}
for change in changes:
	print('[%d] %s - %s' % (count, change['project'], change['subject']))
	commits[count] = {}
	commits[count]['id'] = change['_number']
	commits[count]['revs'] = change['revisions'][change['current_revision']]['_number']
	commits[count]['project'] = change['project']
	count += 1


commit_id = raw_input("\n\nWhich commit would you like to push to test? ('q' to quit): ")

if (commit_id == 0 or commit_id == 'q'):
	exit
else:
	commit_id = int(commit_id)
	commit = commits[commit_id]
	short_id = str(commit['id'])[-2:]
	commit_id = commit['id']
	rev = commit['revs']

	print('\nStarting Build for Commit %s Revision %s' % (commit_id, rev))
	refspec = ('refs/changes/%s/%s/%s' % (short_id, commit_id, rev))

	build_params = {'Action': 'Build_and_Stage_Branch','GERRIT_BRANCH': 'master', 'GERRIT_REFSPEC': refspec}

	j = jenkins.Jenkins('http://jenkins0.dev.returnpath.net', jenkins_user, jenkins_api)

	job_info = j.get_job_info(commit['project'])
	next_build_number = job_info['nextBuildNumber']
	j.build_job(commit['project'], build_params)

	building = False
	while building != True:
		sys.stdout.write('.')
		sys.stdout.flush()
		sleep(1)
		try:
			build_info = j.get_build_info(commit['project'], next_build_number)
			building = build_info['building']
		except:
			pass

	print('\nSuccess see your build here: \n%s\n\n' % (build_info['url']))
