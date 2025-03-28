#!/usr/bin/python3

def detect_test_image():
  if os.environ.get('TEST_IMAGE') is not None:
    return os.environ['TEST_IMAGE']

  return "kasmweb/ubuntu-focal-desktop:develop"

def find_container_for_image(image):
  for container in docker_client.containers.list():
    if container.attrs['Config']['Image'] == image:
        return container

def check_xfce_running(container):
  try:
    check_xfce_cmd = '/bin/bash -c "pgrep xfce4-session"'
    xfce = container.exec_run(check_xfce_cmd)
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

import os

global report_status
global report_tests
global docker_client
report_tests = []
report_status = 'PASS'

TEST_IMAGE = detect_test_image()

import docker
docker_client = docker.from_env()

test_container = find_container_for_image(TEST_IMAGE)
check_xfce_running(test_container)
