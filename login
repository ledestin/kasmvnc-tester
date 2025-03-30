#!/usr/bin/python3

from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
import requests
from requests.auth import HTTPDigestAuth

# Define login credentials
username = "kasm_user"
password = "password"
url = "https://localhost:6901"

# Step 1: Authenticate using requests
session = requests.Session()
response = session.get(url, auth=HTTPDigestAuth(username, password))

# Step 2: Start Selenium with the session
options = Options()
options.add_argument("--ignore-certificate-errors")
options.add_argument("--allow-running-insecure-content")
service = Service("chromedriver")  # Path to your chromedriver
driver = webdriver.Chrome(service=service, options=options)

# Load the page in Selenium
driver.get(url)

# Step 3: Add cookies from the authenticated session
for cookie in session.cookies:
    driver.add_cookie({'name': cookie.name, 'value': cookie.value, 'domain': cookie.domain})

# Refresh to apply cookies
driver.refresh()

# Now interact with the page as an authenticated user
print(driver.title)  # Example interaction

# Close the browser
driver.quit()
