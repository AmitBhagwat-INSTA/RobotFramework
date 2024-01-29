*** Settings ***
Documentation   Selenium-Demo
...             Purpose:    Demo Selenium integration

Library     SeleniumLibrary
Library     ../01-Test_Libraries/test_python_functions.py
Library     my_selenium_library.py          # name of python file MUST be lowercase

Resource       ../01-Test_Libraries/Keywords.resource
Variables      ../01-Test_Libraries/test_variables.py

*** Test Cases ***
Open Browser with Selenium then Close
    Open Browser With Url And Close    Firefox    https://www.google.co.uk/
    my_selenium_library.open_browser_selenium()



