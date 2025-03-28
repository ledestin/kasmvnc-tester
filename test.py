#!/usr/bin/python3

import os

global report_status
global report_tests
report_tests = []
report_status = 'PASS'

if os.environ.get('TEST_IMAGE') is not None:
  TEST_IMAGE = os.environ['TEST_IMAGE']
else:
  TEST_IMAGE = "kasmweb/ubuntu-focal-desktop:develop"

import docker
dockerClient = docker.from_env()

for container in dockerClient.containers.list():
  if container.attrs['Config']['Image'] == TEST_IMAGE:
    testContainer = container

try:
  # Detect the xfce-session pid
  checkXfce = '/bin/bash -c "pgrep xfce4-session"'
  xfce = testContainer.exec_run(checkXfce)
  if xfce[0] == 0:
    pids = xfce[1].decode("utf-8")
    report_tests.append({'testname':'XFCE Running','status':'pass','errorout': 'XFCE is running pid ' + pids})
    print('xfce - complete')
  else:
    report_tests.append({'testname':'XFCE Running','status':'fail','errorout': 'XFCE is not running'})
    report_status = 'FAIL'
    print('xfce - error')
except Exception as error:
  report_tests.append({'testname':'XFCE Running','status':'fail','errorout': error})
  report_status = 'FAIL'
  print('xfce - error')
