*** Settings ***

Documentation       Text file containing common Driver Admin Portal functionality
Library    SeleniumLibrary
Library    String

*** Keywords ***

#Selenium Keywords

Open Driver Admin Portal Page As User
    [Documentation]     Opens Admin Driver Portal As User
    [Arguments]     ${URL}      ${USER}     ${PASS}
    Open Browser        ${URL}      firefox
    Maximize Browser Window
    Wait Until Element Is Visible       id:Email    timeout=60
    Input Text      id:Email    ${USER}
    Input Password      id:PassWord    ${PASS}
    Submit Credentials

Open Driver Portal Page As User
    [Documentation]     Opens Driver Portal As User
    [Arguments]     ${URL}      ${USER}     ${PASS}
    Open Browser        ${URL}      firefox
    Maximize Browser Window
    Wait Until Element Is Visible       id:Email
    Input Text      id:Email    ${USER}
    Input Password      id:Password    ${PASS}
    Submit Credentials Driver Portal

Submit Credentials
    [Documentation]     Credentials are submitted
    Click Button        Login
    Capture Page Screenshot     Login_Page.png

Submit Credentials Driver Portal
    [Documentation]     Credentials are submitted
    Click Button        Sign in
    Capture Page Screenshot     Login_Page.png

Resolve Marketing Preferences Popup
    [Documentation]     Y/N to marketing preferences popup, if present
    [Arguments]     ${Yes_OR_No}
    ${marketing_preferences} =   Run Keyword and Return Status      Page Should Contain     Would you like to receive marketing communication from
    Run Keyword If    ${marketing_preferences}      Click Button    ${Yes_OR_No}

Logout Driver Portal
    [Documentation]     Logout of the Driver Portal
    Click Element    id:dropdownMenuLink
    Click Element    xpath:/html/body/div[1]/div[1]/header/div/div/div[2]/div/div/div/a[3]

Navigate to My Profile Driver Portal
    [Documentation]     Navigate to the My Profile page on Driver Portal
    Click Element    id:dropdownMenuLink
    Click Element    xpath:/html/body/div[1]/div[1]/header/div/div/div[2]/div/div/div/a[1]

Update Fname and Lname Driver Portal
    [Documentation]     Update Driver Fname and Lname
    [Arguments]     ${FName}    ${Lname}
    ${Random_String} =      Generate Random String      5      [LETTERS]
    Wait Until Element Is Visible       id:first_name
    Clear Element Text    id:first_name
    Input Text      id:first_name    ${FName}${Random_String}
    Clear Element Text    id:last_name
    Input Text      id:last_name    ${LName}${Random_String}

Update Address Driver Portal
    [Documentation]     Update Driver Address
    [Arguments]     ${ADDRESS}
    Clear Element Text    id:personalAddress
    Input Text    id:personalAddress    ${ADDRESS}

Update Billing Address Driver Portal
    [Documentation]     Update Driver Billing Address
    [Arguments]     ${ADDRESS}
    Clear Element Text    id:billingAddress
    Input Text    id:billingAddress    ${ADDRESS}

#Select Same Address Checkbox If Unselected Driver Portal
#    [Documentation]     Select 'Same address as personal address' Checkbox if unselected
#    ${checkbox_unselected} =   Run Keyword and Return Status      Checkbox Should Not Be Selected    id:same-address
#    Run Keyword If    ${checkbox_unselected}      Select Checkbox     id:same-address
#    ${checkbox_unselected} =   Run Keyword and Return Status      Checkbox Should Not Be Selected    xpath:/html/body/div[1]/div[1]/main/div/div/div[2]/form[1]/div[4]
#    Run Keyword If    ${checkbox_unselected}      Select Checkbox     xpath:/html/body/div[1]/div[1]/main/div/div/div[2]/form[1]/div[4]

Check Billing Address Matches Personal Address Driver Portal
    [Documentation]     Check that the driver's billing address is the same as their personal address
    ${Current_Personal_Address} =   Get Text    id:personalAddress
    Element Text Should Be    id:billingAddress    ${Current_Personal_Address}