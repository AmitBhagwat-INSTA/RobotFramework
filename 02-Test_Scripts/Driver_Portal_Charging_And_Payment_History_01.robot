*** Settings ***
Documentation   Instavolt-Driver-Portal-Login
...             Purpose:    Logout

Library     SeleniumLibrary

Resource       ../01-Test_Libraries/Keywords.resource
Variables      ../01-Test_Libraries/test_variables.py

*** Test Cases ***
Driver-Portal-Charging-And-Payment-History-01 1.1 - Open Driver Portal Page and Log In
    Open Driver Portal Page As User     ${LOGIN_URL}    ${OLI_USERNAME}    ${OLI_PASSWORD}
    Wait Until Page Contains    Charging & Payment History    timeout=60
    Sleep                               5s
    Capture Page Screenshot     Charging_And_Payment_History.png
    Resolve Marketing Preferences Popup     No
    Sleep                               10s
#    Close Browser

Driver-Portal-Charging-And-Payment-History-01 1.2 - Logout of the Driver Portal
    ????
