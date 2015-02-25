
import os
import sys
import json
import pprint
import ConfigParser
import urllib
import urllib2
import jenkins
import time
from time import sleep;

pp = pprint.PrettyPrinter(indent=4)

"""
 Returns a terminal color format string
"""
def termcolor(style=None, fg=None, bg=None):
	ret_val = ''

	# this prints a table of everything
	if 'colortable' == style:
		print '\x1b[0m'
		color_string = ''
		for style in xrange(8):
			for fg in xrange(30,38):
				for bg in xrange(40,48):
					format = ';'.join([str(style), str(fg), str(bg)])
					color_string += '\x1b[%sm %s \x1b[0m' % (format, format)
				color_string += '\n'
			color_string += '\n'
		ret_val = color_string

	elif None == style or 'default' == style:
		ret_val = '\x1b[0m'

	elif 'bold' == style:
		ret_val = '\x1b[1m'

	elif 'highlight' == style:
		ret_val = '\x1b[3m'

	elif 'underline' == style:
		ret_val = '\x1b[4m'

	elif 'blink' == style:
		ret_val = '\x1b[5m'

	elif 0 > style or 8 < style:
		message = 'style out of range : "%s"' % (style)
		raise Exception(message)

	elif 30 > fg or 38 < fg or None == fg:
		message = 'fg out of range : "%s"' % (fg)
		raise Exception(message)

	elif 40 > bg or 48 < bg or None == bg:
		message = 'bg out of range : "%s"' % (bg)
		raise Exception(message)

	else:
		format = ';'.join([str(style), str(fg), str(bg)])
		ret_val = '\x1b[%sm' % (format)

	return ret_val


"""
 Get and validate the target command line argument
"""
def getTarget():
	target = None

	targets = ['ci', 'test', 'prod']
	target = sys.argv[1]
	if not target in targets:
		message = '"' + target + '" is not a vaild build target'
		raise Exception(message)

	return target


"""
 Check Gerrit to see if this is a valid project (project has at least one merged
 commit).  If one is found, return the matching Gerrit config
"""
def getGerritInfo(project, git_user_name):
	ret_val = {}
	servers = getServerConfigs('gerrit')
	for server in servers:

		# Find last merged change
		changes = json.loads(''.join(urllib2.urlopen(server['url']+'?q=is:merged+project:'+project+'+limit:1&o=CURRENT_REVISION').readlines()[1:]))
		if 0 < len(changes) and 'subject' in changes[0]:
			ret_val['server'] = server;
			ret_val['changes'] = {
				'master': changes,
				'others': [],
				'mine': []
			}

			# Find my changes

			# Find unmerged changes
			changes = json.loads(''.join(urllib2.urlopen(server['url']+'?q=is:open+project:'+project+'&o=CURRENT_REVISION').readlines()[1:]))
			for change in changes:
				if (change['owner']['name'] != git_user_name):
					ret_val['changes']['others'].append(change)
				else:
					ret_val['changes']['mine'].append(change)

			return ret_val

	raise Exception('No Gerrit project named "'+project+'" could be found')


"""
 Check Jenkins to see if this is a valid project. If one is found, return the
 matching Jenkins config
"""
def getJenkinsInfo(project):
	servers = getServerConfigs('jenkins')


	for server in servers:
		try:
			j = jenkins.Jenkins(server['host'], server['user'], server['key'])
			job_info = j.get_job_info(project)
			return {'server': server, 'jenkins': j}

		except jenkins.JenkinsException as e:
			sys.exc_clear()
	raise Exception('No Jenkins project named "'+project+'" could be found')


"""
 Get a server config value and parse it as a JSON string
"""
def getServerConfigs(system):
	conf = ConfigParser.ConfigParser()
	conf.read(os.path.dirname(__file__)+'/../build.conf')
	return json.loads(conf.get(system, 'servers'))


"""
 asfda
"""
def selectCommitFromInput(gerrit_info, git_user_name):
	count = 0
	commits = {}

	# Build master screen
	code_reviews = ('\nCurrent master:')
	print(code_reviews)
	print (len(code_reviews) -1 ) * '-'
	print('    [%d] %s' % (count, gerrit_info['changes']['master'][0]['subject']))
	commits[count] = gerrit_info['changes']['master'][0]
	count += 1

	# My code reviews screen
	code_reviews = ('\n\nMy open reviews:')
	print(code_reviews)
	print (len(code_reviews) -1 ) * '-'
	for change in gerrit_info['changes']['mine']:
		print('    [%d] %s' % (count, change['subject']))
		commits[count] = change
		count += 1

	# All code reviews screen
	code_reviews = ('\n\nOpen reviews for other committers:')
	print(code_reviews)
	print (len(code_reviews) -1 ) * '-'
	for change in gerrit_info['changes']['others']:
		if change['owner']['name'] != git_user_name:
			print('    [%d] (%s) %s' % (count, change['owner']['name'], change['subject']))
			commits[count] = change
			count += 1

	# Prompt
	commit_id = raw_input("\n\nWhich commit would you like to build for test? ('q' to quit): ")

	if commit_id == 'q':
		quit()

	else:
		return commits[int(commit_id)]


"""
 asfda
"""
def buildJenkinsProject(project, gerrit_info, jenkins_info, target, change):
	change_id = change['_number'];
	refspec = ('refs/changes/%s/%s/%s' % (str(change['_number'])[-2:], change['_number'], change['revisions'][change['current_revision']]['_number']))

	build_params = {}
	if 'ci' == target:
		build_params = {'Action': 'Build_and_Stage_Ci','GERRIT_BRANCH': 'master', 'GERRIT_REFSPEC': refspec}
	elif 'test' == target:
		build_params = {'Action': 'Build_and_Stage_Branch','GERRIT_BRANCH': 'master', 'GERRIT_REFSPEC': refspec}
	elif 'prod' == target:
		build_params = {'Action': 'Release','GERRIT_BRANCH': 'master', 'GERRIT_REFSPEC': 'refs/heads/master'}
	else:
		raise Exception('Invalid target')



	print('\nStarting Build for Commit %s Revision %s' % (change_id, refspec))

	# Trigger the build and wait for a success response
	job_info = jenkins_info['jenkins'].get_job_info(project)
	next_build_number = job_info['nextBuildNumber']
	jenkins_info['jenkins'].build_job(project, build_params)

	result = None
	start = time.time()
	build_info = {'estimatedDuration': 'waiting'}
	link_printed = False
	sleep(2)
	count = 0
	spinner = ['\\','|','/','-']
	spin = ''
	while result == None:
		spin = spinner[count % 4]
		try:
			build_info = jenkins_info['jenkins'].get_build_info(project, next_build_number)
			result = build_info['result']
			if result != None:
				break
		except:
			pass
		duration = time.time() - start
		if build_info['estimatedDuration'] == 'waiting':
			sys.stdout.write(termcolor(0, 33, 40)+"["+spin+"]"+termcolor()+" Waiting for build to start... \r")
		else:
			if not link_printed:
				link_printed = True
				print "\nBuild started, see your build here: "+termcolor(0, 36, 40)+"{url}".format(url=build_info['url'])+termcolor('default')
				count = 0

			seconds = max(build_info['estimatedDuration']/1000 - duration, 0)
			if(seconds > 0):
				m, s = divmod(seconds, 60 * 8)
				h, m = divmod(m, 60 * 8)
				sys.stdout.write(termcolor(0, 32, 40)+"["+spin+"]"+termcolor()+" Estimated time remaining: %d:%02d:%02d \r" % (h, m, s))
			else:
				m, s = divmod(count / 8, 60 * 8)
				h, m = divmod(m, 60 * 8)
				# the whitespace is on purpose
				sys.stdout.write(termcolor(0, 35, 40)+"["+spin+"]"+termcolor()+" Elapsed time: %d:%02d:%02d                                                                                 \r" % (h, m, s))

		sys.stdout.flush()
		sleep(0.125)
		count += 1

	if(build_info['result'] == "SUCCESS"):
		print termcolor(0, 32, 40)
		print '\nBuild succeeded, push your build here: '+termcolor(0, 36, 40)+'http://rm.returnpath.net/rpinstall/'
	else:
		print termcolor(0, 31, 40)
		print '\nBuild failed, review your build here: '+termcolor(0, 36, 40)+'{url}'
	print termcolor('default')














