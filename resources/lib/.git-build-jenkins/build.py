#!/usr/bin/env python

# README:
# pip install python-jenkins
#   https://python-jenkins.readthedocs.org/en/latest/example.html
# configure user as your git author name
# configure jenkins user as your jenkins username
# configure jenkins api as your jenkins api token
#   http://jenkins0.dev.returnpath.net/user/<username>/configure
#   Click "Show My Token" button


import json
import httplib
import jenkins
import sys
import os
import subprocess

from build.functions import *

target = getTarget()
project = sys.argv[2]
git_user_name = subprocess.check_output(['git', 'config', 'user.name']).strip()
gerrit_info = getGerritInfo(project, git_user_name)
jenkins_info = getJenkinsInfo(project)

if 'ci' == target or 'test' == target:
	change = selectCommitFromInput(gerrit_info, git_user_name)

else:
	change = gerrit_info['changes']['master'][0]

buildJenkinsProject(project, gerrit_info, jenkins_info, target, change)
