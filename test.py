#!/usr/bin/python3

import os

global report_status
global report_tests
global docker_client
report_tests = []
report_status = 'PASS'

if os.environ.get('TEST_IMAGE') is not None:
  TEST_IMAGE = os.environ['TEST_IMAGE']
else:
  TEST_IMAGE = "kasmweb/ubuntu-focal-desktop:develop"

import docker
docker_client = docker.from_env()

def find_container_for_image(image):
  for container in docker_client.containers.list():
    if container.attrs['Config']['Image'] == image:
        return container

test_container = find_container_for_image(TEST_IMAGE)
try:
  # Detect the xfce-session pid
  check_xfce = '/bin/bash -c "pgrep xfce4-session"'
  xfce = test_container.exec_run(check_xfce)
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
