*** Settings ***
Documentation   Driver_Portal_My_Profile_04
...             Purpose:    Check that when the user clicks the 'Same as personal address' checkbox, the billing
...             address is updated to match the user's personal address.

Library     SeleniumLibrary

Resource       ../01-Test_Libraries/Keywords.resource
Variables      ../01-Test_Libraries/test_variables.py

*** Test Cases ***
Driver-Portal-My-Profile-04 1.1 - Open Driver Portal Page and Log In
    Open Driver Portal Page As User     ${LOGIN_URL}    ${OLI_USERNAME}    ${OLI_PASSWORD}
    Wait Until Page Contains    Charging & Payment History    timeout=60
    Sleep                               5s
    Capture Page Screenshot     Charging_And_Payment_History_04.png
    Resolve Marketing Preferences Popup     No
    Sleep                               10s
    Click Button    I Accept

Driver-Portal-My-Profile-04 1.2 - Navigate to My Profile
    Navigate to My Profile Driver Portal
    Wait Until Page Contains    Personal Details
    Capture Page Screenshot     My_Profile_04.png

Driver-Portal-My-Profile-04 1.3 - Check Billing Address Is The Same As Personal Address
    Sleep       2s
    #Select Checkbox     id:same-address       # Does nothing if checbox is already selected
    Click Element At Coordinates    id:same-address    519    889
    Sleep       2s
    Check Billing Address Matches Personal Address Driver Portal
    Click Button    Save
    Wait Until Page Contains    Driver profile updated successfully
    Capture Page Screenshot     Billing_Address_Same_As_Personal_04.png
    Close Browser
