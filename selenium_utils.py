#!/usr/bin/python3

from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options

def create_driver():
    # Set up Chrome options for headless browsing
    chrome_options = Options()
    chrome_options.add_argument('--ignore-certificate-errors')

    # docker flags
    chrome_options.add_argument("--disable-gpu")
    chrome_options.add_argument("--no-sandbox")
    chrome_options.add_argument("--disable-extensions")
    chrome_options.add_argument("--disable-dev-shm-usage")
    chrome_options.add_argument("--allow-insecure-localhost")
    chrome_options.add_argument("--window-size=1420,1080")

    # Specify the path to the ChromeDriver executable
    webdriver_path = '/usr/bin/chromedriver'  # Replace with the actual path
    # Set up the Chrome service
    chrome_service = Service(webdriver_path)
    # Initialize the Chrome driver
    driver = webdriver.Chrome(service=chrome_service, options=chrome_options)
    return driver

driver = create_driver()
driver.get(f"https://localhost")
