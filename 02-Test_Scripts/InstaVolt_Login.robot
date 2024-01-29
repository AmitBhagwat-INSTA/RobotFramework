*** Settings ***
Documentation   Instavolt-Login
...             Purpose:    POC Test Case to demonstrate Robot Framework functionality

Library     SeleniumLibrary

Resource       ../01-Test_Libraries/Keywords.resource
Variables      ../01-Test_Libraries/test_variables.py

*** Test Cases ***
InstaVolt-Login 1.1 - Open Driver Admin Page and Log In
    Open Driver Admin Portal Page As User     ${LOGIN_URL}    ${OLI_USERNAME}    ${OLI_PASSWORD}
    Wait Until Page Contains    Dashboard    timeout=60
    Sleep                               5s
    Capture Page Screenshot     DashboardPage.png
    Close Browser