*** Settings ***
Documentation   Driver_Portal_My_Profile_03
...             Purpose:    Update Driver billing address on My Profile page

Library     SeleniumLibrary

Resource       ../01-Test_Libraries/Keywords.resource
Variables      ../01-Test_Libraries/test_variables.py

*** Test Cases ***
Driver-Portal-My-Profile-03 1.1 - Open Driver Portal Page and Log In
    Open Driver Portal Page As User     ${LOGIN_URL}    ${OLI_USERNAME}    ${OLI_PASSWORD}
    Wait Until Page Contains    Charging & Payment History    timeout=60
    Sleep                               5s
    Capture Page Screenshot     Charging_And_Payment_History_03.png
    Resolve Marketing Preferences Popup     No
    Sleep                               10s
    Click Button    I Accept

Driver-Portal-My-Profile-03 1.2 - Navigate to My Profile
    Navigate to My Profile Driver Portal
    Wait Until Page Contains    Personal Details
    Capture Page Screenshot     My_Profile_03.png

Driver-Portal-My-Profile-03 1.3 - Update Driver Billing Address
    Sleep       2s
    Update Billing Address Driver Portal    ${DRIVER_ADDRESS}
    Sleep       2s
    Click Button    Save
    Wait Until Page Contains    Driver profile updated successfully
    Capture Page Screenshot     Updated_Billing_Address_03.png
    Close Browser
