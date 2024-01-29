*** Settings ***

Documentation       Text file containing common Android Mobile App functionality
Library    AppiumLibrary
Library    String

*** Keywords ***

Open Instavolt Driver Application To Splash Screen On Device
    [Documentation]     Opens Instavolt Driver Mobile App
    [Arguments]     ${DEVICE_NAME}
    Open Application      http://localhost:4723
    ...                   automationName=UiAutomator2
    ...                   platformName=Android
    ...                   deviceName='${DEVICE_NAME}'
    #...                   platformVersion=14
    ...                   appPackage=com.app.instavolt
    ...                   appActivity=com.app.instavolt.ui.splash.SplashActivity
    ...                   appium:settings[waitForIdleTimeout]=${100}
    #...                   appium:udid=34101JEHN08405


### Logins and Logout ###

Login To Android Driver App As Non Federated User
    [Documentation]     Login to Android Driver App As Non Federated User
    [Arguments]     ${USER}     ${PASS}
    Wait Until Element Is Visible    id=com.app.instavolt:id/btnSignIn
    Click Element    id=com.app.instavolt:id/btnSignIn
    Wait Until Element Is Visible    id=com.app.instavolt:id/tieEmail
    Clear Text    com.app.instavolt:id/tieEmail
    Input Text    com.app.instavolt:id/tieEmail    ${USER}
    Clear Text    com.app.instavolt:id/tiePassword
    Input Text    com.app.instavolt:id/tiePassword    ${PASS}
    Submit Credentials - Sign in

Login to Android Driver App As Google User
    [Documentation]     Login to Android Driver App As Google User
    [Arguments]     #${GMAIL}       # May need to pass given gmail account if multiple gmail accounts are available for login
                                    # This should occur on physical device.
    Wait Until Element Is Visible    com.app.instavolt:id/btnSignIn
    Click Element    com.app.instavolt:id/btnSignIn
    Wait Until Element Is Visible    com.app.instavolt:id/btnGoogle
    Click Element    com.app.instavolt:id/btnGoogle
    # Resolve if multiple google accounts available... Run keyword if page found that has options to select a given gmail account...

Login to Android Driver App As Facebook User
    [Documentation]     Login to Android Driver App As Non Federated User. Assumes user has already signed in with FB account once
    # Since first time sign in sends us to Facebook, that scenario will not be automated as it uses third party software (FB).
    [Arguments]
    Wait Until Element Is Visible    com.app.instavolt:id/btnSignIn
    Click Element    com.app.instavolt:id/btnSignIn
    Wait Until Element Is Visible    com.app.instavolt:id/btnFacebook
    Click Element    com.app.instavolt:id/btnFacebook

Submit Credentials - Sign in
    [Documentation]     Credentials are submitted on sign in screen
    Click Element    com.app.instavolt:id/btnSignIn
    Capture Page Screenshot     Android_Login_Page.png

Logout
    [Documentation]     Logs the user out of the App.
    [Arguments]     ${Yes_Or_No}
    Click Element    com.app.instavolt:id/txtlogout
    ${Logout_Popup_Text_Presence} =   Run Keyword and Return Status      Page Should Contain Text     Are you sure you want to logout?
    Run Keyword If    '${Logout_Popup_Text_Presence}' == 'True' and '${Yes_Or_No}' == 'No'     Click Element    android:id/button2
    Run Keyword If    '${Logout_Popup_Text_Presence}' == 'True' and '${Yes_Or_No}' == 'Yes'      Click Element    android:id/button1
    # May need to add scenerio where user is logged in to multiple accounts, thereby unlocking the 'switch account' option. The popup text is different for second scenario.


### Sign ups ###

Sign Up To Android Driver App As Non Federated User
    [Documentation]     Sign Up to Android Driver App As Non Federated User
    [Arguments]     ${F_NAME}     ${L_NAME}     ${EMAIL}    ${PASSWORD}
    Wait Until Element Is Visible    com.app.instavolt:id/btnRegister
    Click Element    com.app.instavolt:id/btnRegister
    Wait Until Element Is Visible    com.app.instavolt:id/tieFirstName
    Clear Text    com.app.instavolt:id/tieFirstName
    Input Text    com.app.instavolt:id/tieFirstName    ${F_NAME}
    Clear Text    com.app.instavolt:id/tieLastName
    Input Text    com.app.instavolt:id/tieLastName    ${LNAME}
    Clear Text    com.app.instavolt:id/tieEmail
    Input Text    com.app.instavolt:id/tieEmail    ${EMAIL}
    Clear Text    com.app.instavolt:id/tiePassword
    Input Text    com.app.instavolt:id/tiePassword    ${PASSWORD}
    Submit Credentials - Sign Up
    # Needed - tool to gather OTP code from email. Would need to be either gmail account or outlook, I suspect.
    # I can then write a keyword to enter OTP code

Submit Credentials - Sign Up
    [Documentation]     Credentials are submitted on sign up screen.
    Click Element    com.app.instavolt:id/btnSubmit
    Capture Page Screenshot     Android_Sign_Up_Page.png

Sign Up To Android Driver App As Google User
    [Documentation]     Sign Up to Android Driver App As Google User
    # May need arg for email. Assumes user has a gmail account available.
    Wait Until Element Is Visible    com.app.instavolt:id/btnRegister
    Click Element    com.app.instavolt:id/btnRegister
    Wait Until Element Is Visible   com.app.instavolt:id/btnGoogle
    Click Element    com.app.instavolt:id/btnGoogle

Sign Up To Android Driver App As Facebook User
    [Documentation]     Sign Up to Android Driver App As Google User
    # Assumes user has a facebook account available.
    Wait Until Element Is Visible    com.app.instavolt:id/btnRegister
    Click Element    com.app.instavolt:id/btnRegister
    Wait Until Element Is Visible   com.app.instavolt:id/btnFacebook
    Click Element    com.app.instavolt:id/btnFacebook


### Resolve Popups and Pages ###

Resolve OTP Popup
    [Documentation]     Resolve the OTP Popup during sign up.6+3
    [Arguments]     ${USER_CHOICE}      ${SIGN_UP_EMAIL}
    Wait Until Element Is Visible    android:id/message
    ${OTP_Popup_Text_Presence} =    Run Keyword and Return Status   Page Should Contain Text    Hey, we are going to send you the OTP code to ${SIGN_UP_EMAIL}, Please make sure you have entered a valid email address.
    Run Keyword If    '${OTP_Popup_Text_Presence}' == 'True' and '${USER_CHOICE}' == 'Cancel'   Click Element    android:id/button2
    Run Keyword If    '${OTP_Popup_Text_Presence}' == 'True' and '${USER_CHOICE}' == 'Yes its correct'   Click Element    android:id/button1

Resolve Facebook Popup      # Untested. May be able to be used in both sign in and sign up processes.
    [Documentation]     Resolve Facebook Popup that recognises previous login, if present.
    [Arguments]     ${USER_CHOICE}
    Wait Until Page Contains    You previously logged in to
    Page Should Contain Text    with Facebook
    ${Facebook_Page_Text_Presence} =    Run Keyword and Return Status   Page Should Contain Text    m.facebook.com
    Run Keyword If    '${Facebook_Page_Text_Presence}' == 'True' and '${USER_CHOICE}' == 'Continue'     Click Text    Continue as     #Click Element    u_0_0_VL
    Run Keyword If    '${Facebook_Page_Text_Presence}' == 'True' and '${USER_CHOICE}' == 'Cancel'       Click Text    Cancel      #Click Element     u_0_1_OW

Resolve Marketing Preferences Page
    [Documentation]     Yes/No to marketing preferences page, if present
    [Arguments]     ${USER_CHOICE}
    Wait Until Page Contains    Next
    ${Marketing_Page_Text_Presence} =   Run Keyword and Return Status      Page Should Contain Text     Next
    Run Keyword If    '${Marketing_Page_Text_Presence}' == 'True' and '${USER_CHOICE}' == 'Yes'     Click Element    xpath=(//android.widget.ImageView[@resource-id="com.app.instavolt:id/ivIcon"])[2]
    Run Keyword If    '${Marketing_Page_Text_Presence}' == 'True' and '${USER_CHOICE}' == 'No'     Click Element    xpath=(//android.widget.ImageView[@resource-id="com.app.instavolt:id/ivIcon"])[3]
    Click Element    com.app.instavolt:id/btnNext

Resolve Location Access Popup
    [Documentation]     Resolve Location access popup (foreground only/allow one time/deny)
    [Arguments]     ${USER_CHOICE}
    Wait Until Page Contains    Allow InstaVolt to access this device’s location?
    # or until element is visible? com.android.permissioncontroller:id/grant_dialog
    ${Location_Popup_Text_Presence} =    Run Keyword and Return Status      Page Should Contain Text     Allow InstaVolt to access this device’s location?
    Run Keyword If    '${Location_Popup_Text_Presence}' == 'True' and '${USER_CHOICE}' == 'While using the app'     Click Element    com.android.permissioncontroller:id/permission_allow_foreground_only_button
    Run Keyword If    '${Location_Popup_Text_Presence}' == 'True' and '${USER_CHOICE}' == 'Only this time'     Click Element    com.android.permissioncontroller:id/permission_allow_one_time_button
    Run Keyword If    '${Location_Popup_Text_Presence}' == 'True' and '${USER_CHOICE}' == "Don't allow"     Click Element    com.android.permissioncontroller:id/permission_deny_button

Resolve Premium Service Popup
    [Documentation]     Subscribe or not now to premium service popup, if present
    [Arguments]     ${USER_CHOICE}
    Wait Until Page Contains    SUBSCRIBE
    ${Premium_Popup_Text_Presence} =   Run Keyword and Return Status      Page Should Contain Text     SUBSCRIBE
    Run Keyword If    '${Premium_Popup_Text_Presence}' == 'True' and '${USER_CHOICE}' == 'SUBSCRIBE'     Click Element    com.app.instavolt:id/btnSubscribe
    Run Keyword If    '${Premium_Popup_Text_Presence}' == 'True' and '${USER_CHOICE}' == 'MAYBE LATER'      Click Element    com.app.instavolt:id/btnNotNow

Resolve Charge Station Numbering Popup
    [Documentation]     'Got it' or 'Show next time' to numbering popup, if present
    [Arguments]     ${USER_CHOICE}
    Wait Until Page Contains    Our charge stations are numbered from left to the right.
    ${Numbering_Popup_Text_Presence} =   Run Keyword and Return Status      Page Should Contain Text     Our charge stations are numbered from left to the right.
    Run Keyword If    '${Numbering_Popup_Text_Presence}' == 'True' and '${USER_CHOICE}' == 'Got it'     Click Element    com.app.instavolt:id/btnGotIt
    Run Keyword If    '${Numbering_Popup_Text_Presence}' == 'True' and '${USER_CHOICE}' == 'Show next time'      Click Element    com.app.instavolt:id/btnShowNextTime


### Charging ###

Navigate to Charging Station from List Button
    [Documentation]     Navigate to a given charging station detail page
    [Arguments]     #${SEARCH_TERM}
    Wait Until Element Is Visible    com.app.instavolt:id/imgChargeStationList
    Click Element    com.app.instavolt:id/imgChargeStationList
    Wait Until Element Is Visible    com.app.instavolt:id/imgOptionMenuThird
    #Click Element    com.app.instavolt:id/imgOptionMenuThird
    #Wait Until Element Is Visible    com.app.instavolt:id/txtAutoComplete
    #Input Text    com.app.instavolt:id/txtAutoComplete    ${SEARCH_TERM}
    # I don't think I can click an element from the resulting drop down... Can I send the keys instead?
    Click Element    xpath=//android.widget.TextView[@resource-id="com.app.instavolt:id/txtStationTitle" and @text="SPINDLEWOOD-DRV"]

Slide to Charge
    [Documentation]     The user swipes right to charge
    #${Swipe_Bar_Location} =     Get Element Location    xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id="com.app.instavolt:id/rvDrawerLayout"]/android.view.ViewGroup[5]       # - I will probably want to get the location, to then be able to swipe at the correct point regardless of the device, ideally...
    #Log    Location of slider row is ${Swipe_Bar_Location}
    Swipe By Percent    55      58      100     58      500  # I think I need to Swipe By Percent to ensure this works on other devices.
    Sleep   10s

Resolve All Pre-Charge Scenerios
    [Documentation]     Resolve all scenarios the user may face before starting the charge
    Sleep    10s
    # Resolve when Popup appears with text "We are unable to connect to the charging station at this moment, Please try again." , then need to click Ok button on popup which has this id, android:id/button1
    ${Unable_Popup_Text_Presence} =   Run Keyword and Return Status      Page Should Contain Text     We are unable to connect to the charging station at this moment
    Run Keyword If    ${Unable_Popup_Text_Presence}     Click Element    android:id/button1
    Sleep    5s
    # If the charge icon now exists, I need to click it (it's the icon to retun to progress of charge) com.app.instavolt:id/imgChargeProgressIndicator
    ${Return_To_Charge_Icon_Presence} =     Run Keyword And Return Status    Page Should Contain Element    com.app.instavolt:id/imgChargeProgressIndicator
    Run Keyword If    ${Return_To_Charge_Icon_Presence}    Click Element    com.app.instavolt:id/imgChargeProgressIndicator
    Sleep    5s

    # I know i'm on charging screen if the page contains the text 'Charging Progress'....
    # also, need to loop resolve keyword until either start charge screen OR the actual charging screen pages reached

Current Screen Should be Find a Charger
    [Documentation]     Check 'common' elements on find a charger screen to confirm we are currently on this screen
    Page Should Contain Element    com.app.instavolt:id/imgInstaVoltLogo
    Page Should Contain Element    com.app.instavolt:id/imgHamburger
    Page Should Contain Element    com.app.instavolt:id/imgSearch
    Page Should Contain Element    com.app.instavolt:id/imgCurrentLocation
    Page Should Contain Element    com.app.instavolt:id/imgChangeMapView


### Tutorial Screens ###

Verify Tutorial Screens and Buttons     # This seems like more of a test case than a keyword so I may remove this.
    Wait Until Page Contains    Tutorial
    # Check content on each page
    Verify Tutorial Screen By Number   ${1}
    Capture Tutorial Screen Number Screenshot    ${1}
    Click Tutorial Next Button
    Verify Tutorial Screen By Number   ${2}
    Capture Tutorial Screen Number Screenshot    ${2}
    Click Tutorial Next Button
    Verify Tutorial Screen By Number   ${3}
    Capture Tutorial Screen Number Screenshot    ${3}
    Click Tutorial Next Button
    Verify Tutorial Screen By Number   ${4}
    Capture Tutorial Screen Number Screenshot    ${4}
    Click Tutorial Next Button
    Verify Tutorial Screen By Number   ${5}
    Capture Tutorial Screen Number Screenshot    ${5}
    # Verify page buttons at bottom of screen
    Click Tutorial Page Number    ${1}
    Verify Tutorial Screen By Number   ${1}
    Click Tutorial Page Number    ${2}
    Verify Tutorial Screen By Number   ${2}
    Click Tutorial Page Number    ${3}
    Verify Tutorial Screen By Number   ${3}
    Click Tutorial Page Number    ${4}
    Verify Tutorial Screen By Number   ${4}
    Click Tutorial Page Number    ${5}
    Verify Tutorial Screen By Number   ${5}
    Click Tutorial Get Started Button
    # Confirm I'm on find a charger screen
    Current Screen Should be Find a Charger
    # Navigate back to tutorial page, click next once, then skip
    Click Hamburger Menu on Find a Charger Screen
    Click Tutorial
    Click Tutorial Next Button
    Click Tutorial Skip Button
    # Confirm I'm back on find a charger screen
    Current Screen Should be Find a Charger

Verify Tutorial Screen By Number
    [Documentation]     Verify the given Tutorial screen content based on page number
    [Arguments]     ${Page_Number}
    Page Should Contain Element    com.app.instavolt:id/txtSkip
    Run Keyword If    ${Page_Number} == 1    Page Should Contain Text    Welcome
    Run Keyword If    ${Page_Number} == 2 or ${Page_Number} == 3 or ${Page_Number} == 4    Page Should Contain Text    HOW TO CHARGE
    Run Keyword If    ${Page_Number} == 2    Page Should Contain Text    Find a charger
    Run Keyword If    ${Page_Number} == 3    Page Should Contain Text    Start your charge
    Run Keyword If    ${Page_Number} == 4    Page Should Contain Text    Plugging in
    Run Keyword If    ${Page_Number} == 5    Page Should Contain Element    com.app.instavolt:id/btnGetStarted
    Run Keyword If    ${Page_Number} == 5    Page Should Not Contain Element    com.app.instavolt:id/txtNext

Capture Tutorial Screen Number Screenshot
    [Documentation]     Capture Tutorial screen screenshot based on page number
    [Arguments]     ${Page_Number}
    Capture Page Screenshot     Tutorial_Screen_${Page_Number}.png

Click Tutorial Skip Button
    [Documentation]     Click Tutorial screen Skip button
    Wait Until Page Contains    com.app.instavolt:id/txtSkip
    Click Element    com.app.instavolt:id/txtSkip

Click Tutorial Next Button
    [Documentation]     Click Tutorial screen Next button
    Click Element    com.app.instavolt:id/txtNext

Click Tutorial Page Number
    [Documentation]     Click given tutorial screen page number from indicators at bottom of screen.
    [Arguments]     ${Page_Number}
    Click Element    com.app.instavolt:id/viewIndicator${Page_Number}

Click Tutorial Get Started Button
    [Documentation]     Click Tutorial screen 'Get Started' button
    Click Element    com.app.instavolt:id/btnGetStarted


### FAQ's Screen ###
# I think I will need to recontruct these based on coords, since elements could not be found, despite the xpaths..
# Perhaps there is an element overlapping these...

Verify Question Expanding Behaviour
    [Documentation]     Verify the behaviour if the user expands a question while another question is already expanded.
    Wait Until Page Contains    Does InstaVolt use renewable energy sources to power the network?
    Click Element    xpath=//android.widget.TextView[@text="How do I use the App to charge my car?"]
    Page Should Contain Text    Using our app couldn't be easier. First, use the 'Find a Charger' function to locate your nearest InstaVolt charger.
    Click Element    xpath=//android.widget.TextView[@text="How does the Volts rewards scheme work?"]
    Page Should Contain Text    Volts is our new reward program, where drivers can earn rewards every time they charge on the InstaVolt network.
    Page Should Not Contain Text    Using our app couldn't be easier. First, use the 'Find a Charger' function to locate your nearest InstaVolt charger.
    # check text of currently opened question
    # open another question
    # confirm new text is visible
    # confirm old text is gone

Verify Question Collapse Behaviour
    [Documentation]     Verify that the user is able to collapse the FAQ's question.
    Sleep    6s
    #Click Element    xpath=//android.widget.TextView[@text="How do I use the App to charge my car?"]
    Click Element    xpath=//android.view.View[@resource-id="faq-wrapper"]/android.view.View[1]
    Page Should Contain Text    Using our app couldn't be easier. First, use the 'Find a Charger' function to locate your nearest InstaVolt charger.
    Click Element    xpath=//android.widget.TextView[@text="How do I use the App to charge my car?"]
    Page Should Not Contain Text    Using our app couldn't be easier. First, use the 'Find a Charger' function to locate your nearest InstaVolt charger.
    # open question
    # check text of currently opened question
    # close currently opened question
    # check the text is gone

Verify Price In FAQ Questions
    [Documentation]     Verify the system will display the price in defined FAQ which is configured in the "FAQ Price Per kWh" configuration key pair.
    [Arguments]     ${FAQ_Price_Per_kWh}
    Wait Until Page Contains    Does InstaVolt use renewable energy sources to power the network?
    # Open the questions, check for the price text.
    Click Element    xpath=//android.widget.TextView[@text="Is there a minimum spend or connection charge?"]
    Page Should Contain Text    ${FAQ_Price_Per_kWh}
    Click Element    xpath=//android.widget.TextView[@text="How much does it cost to charge?"]
    Page Should Contain Text    ${FAQ_Price_Per_kWh}

### About Screen ###

Verify About Screen Version Number
    [Documentation]     Verify the version number outlined on the About screen
    [Arguments]     ${Version_Number}
    Wait Until Page Contains Element    com.app.instavolt:id/txtVersionNumber
    Page Should Contain Text    Version ${Version_Number}

#Verify About Screen Open Source Licenses
#    [Documentation]     Verify that the about us screen contains the relevant info related to the open-source library.
#    Click Element    xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id="com.app.instavolt:id/rvDrawerLayout"]/android.view.ViewGroup[2]
    # Unable to see text on this screen

    # Other About screen tests are verifying images, which may require a specific python library. Perhaps https://pypi.org/project/robotframework-imagecompare/


### Top Left Corner Hamburger Menus, Back Icons, X Icons ###

Click Hamburger Menu on Find a Charger Screen
    [Documentation]     Clicks the hamburger menu in the top left of the 'find a charger' screen
    Wait Until Element Is Visible    com.app.instavolt:id/imgHamburger
    Click Element    com.app.instavolt:id/imgHamburger

Click Navigation Menu
    [Documentation]     Clicks the navigate menu (can be hamburger menu or back button) in the top left when not on the 'find a charger' screen
    Wait Until Element Is Visible    com.app.instavolt:id/imgNavigation
    Click Element    com.app.instavolt:id/imgNavigation

Click X Button
    [Documentation]     Clicks X Button in the top left corner
    Wait Until Element Is Visible    com.app.instavolt:id/imgClose
    Click Element    com.app.instavolt:id/imgClose


### Find a Charger Screen Icons and Buttons ###

Click List Icon
    [Documentation]     Click the 'List' icon on the 'Find a Charger' screen
    Wait Until Element Is Visible    com.app.instavolt:id/imgChargeStationList
    Click Element    com.app.instavolt:id/imgChargeStationList

Click Volts Icon
    [Documentation]     Click the 'Volts' icon on the 'Find a Charger' screen
    Wait Until Element Is Visible    com.app.instavolt:id/imgRewards
    Click Element    com.app.instavolt:id/imgRewards

Click Invite Icon
    [Documentation]     Click the 'Invite' icon on the 'Find a Charger' screen
    Wait Until Element Is Visible    com.app.instavolt:id/imgInviteEarn
    Click Element    com.app.instavolt:id/imgInviteEarn

Click Filter Icon
    [Documentation]     Click the 'Filter' icon on the 'Find a Charger' screen
    Wait Until Element Is Visible    com.app.instavolt:id/imgFilters
    Click Element    com.app.instavolt:id/imgFilters

Click Offers When Tray Closed       #... may need to consider whether it is open or not. may be two separate keywords
    [Documentation]     Click the 'Offers' tray on the 'Find a Charger' screen
    Wait Until Element Is Visible    com.app.instavolt:id/imgLeftStickyView
    # id when closed: com.app.instavolt:id/imgLeftStickyView
    Click Element    com.app.instavolt:id/imgLeftStickyView
    # can't see an element once tray is opened... may need to click by percentage
    Sleep    2s     # Wait for Tray to open

Click Offers When Tray Open
    [Documentation]     Click the 'Offers' Link on the open tray based on device size.
    [Arguments]     ${ANDROID_DEVICE_WIDTH}     ${ANDROID_DEVICE_LENGTH}
    # Offers button percentages: X = 44.4%, Y = 83.9%.
    # We take the Current device resolution from android test variables config file.
    # I need to check whether this works on other devices with different resolutions
    ${X_Position} =     Evaluate     ${ANDROID_DEVICE_WIDTH} * ${44.4} / ${100}
    ${Y_Position} =     Evaluate     ${ANDROID_DEVICE_LENGTH} * ${83.9} / ${100}
    @{OffersButtonPosition}   Create List     ${X_Position}      ${Y_Position}
    @{all_coordinates}      Create List     ${OffersButtonPosition}
    Tap With Positions    ${500}    @{all_coordinates}

Click Search Icon
    [Documentation]     Click the 'Search' icon on the 'Find a Charger' screen
    Wait Until Element Is Visible    com.app.instavolt:id/imgSearch
    Click Element    com.app.instavolt:id/imgSearch

Click Current Location Icon
    [Documentation]     Click the 'Current Location' icon on the 'Find a Charger' screen
    Wait Until Element Is Visible    com.app.instavolt:id/imgCurrentLocation
    Click Element    com.app.instavolt:id/imgCurrentLocation

Click Change Map View Icon
    [Documentation]     Click the 'Change Map View' icon on the 'Find a Charger' screen
    Wait Until Element Is Visible    com.app.instavolt:id/imgChangeMapView
    Click Element    com.app.instavolt:id/imgChangeMapView


### Side Menu Links ###

Click Find a Charger
    [Documentation]     Click the 'Find a Charger' link from the navigation menu
    Click Element    xpath=//android.widget.TextView[@resource-id="com.app.instavolt:id/txtTitle" and @text="Find a Charger"]

Click Payment
    [Documentation]     Click the 'Payment' link from the navigation menu
    Click Element    xpath=//android.widget.TextView[@resource-id="com.app.instavolt:id/txtTitle" and @text="Payment"]

Click Charging History
    [Documentation]     Click the 'Charging History' link from the navigation menu
    Click Element    xpath=//android.widget.TextView[@resource-id="com.app.instavolt:id/txtTitle" and @text="Charging History"]

Click Promotions
    [Documentation]     Click the 'Promotions' link from the navigation menu
    Click Element    xpath=//android.widget.TextView[@resource-id="com.app.instavolt:id/txtTitle" and @text="Promotions"]

Click Rewards
    [Documentation]     Click the 'Rewards' link from the navigation menu
    Click Element    xpath=//android.widget.TextView[@resource-id="com.app.instavolt:id/txtTitle" and @text="Rewards"]

Click FAQ's
    [Documentation]     Click the 'FAQ's' link from the navigation menu
    Click Element    xpath=//android.widget.TextView[@resource-id="com.app.instavolt:id/txtTitle" and @text="FAQ's"]

Click Tutorial
    [Documentation]     Click the 'Tutorial' link from the navigation menu
    Click Element    xpath=//android.widget.TextView[@resource-id="com.app.instavolt:id/txtTitle" and @text="Tutorial"]

Click Settings
    [Documentation]     Click the 'Settings' link from the navigation menu
    Click Element    xpath=//android.widget.TextView[@resource-id="com.app.instavolt:id/txtTitle" and @text="Settings"]

Click About
    [Documentation]     Click the 'About' link from the navigation menu
    Click Element    xpath=//android.widget.TextView[@resource-id="com.app.instavolt:id/txtTitle" and @text="About"]


# Below are either unfinished or untested. I drafted them up while waiting for DNA payments issue to be resolved.

Logout Or Switch Account    # I think the element id's align with the regular 'logout' keyword above, so I may combine these into one keyword.
    [Documentation]     Logs the user out of the App or allows them to switch to a different account.
    [Arguments]     ${Yes_Cancel_Switch}
    Click Element    com.app.instavolt:id/txtlogout
    ${Logout_Popup_Text_Presence} =   Run Keyword and Return Status      Page Should Contain Text     Please note if you choose to logout this will be actioned on the account currently in use.
    Run Keyword If    '${Logout_Popup_Text_Presence}' == 'True' and '${Yes_Cancel_Switch}' == 'I want to Logout'     Click Element    android:id/button1
    Run Keyword If    '${Logout_Popup_Text_Presence}' == 'True' and '${Yes_Cancel_Switch}' == 'Cancel'      Click Element    android:id/button2
    Run Keyword If    '${Logout_Popup_Text_Presence}' == 'True' and '${Yes_Cancel_Switch}' == 'Switch to another Account'      Click Element    android:id/button3

Switch to Another Account
    [Documentation]     Choose an account to switch to, based on their name
    [Arguments]     ${Driver_Full_Name}
    Click Element    xpath=//android.widget.TextView[@resource-id="com.app.instavolt:id/txtProfileName" and @text="${Driver_Full_Name}"]

#Resolve Marketing Preferences Page
#    [Documentation]     Yes/No to marketing preferences page, if present
#    [Arguments]     ${USER_CHOICE}
#    ${marketing_preferences} =   Run Keyword and Return Status      Page Should Contain Text     Next
#    #@{yesPositionMarketingPref}   Create List     ${94}      ${842}
#    #@{noPositionMarketingPref}   Create List     ${94}      ${925}
#    #@{all_coordinates}      Create List     ${noPositionMarketingPref}
#    #Run Keyword If    ${marketing_preferences}      Tap With Positions    ${500}    @{all_coordinates}
#    Run Keyword If    '${marketing_preferences}' == 'True' and '${USER_CHOICE}' == 'Yes'     Click Element    xpath=(//android.widget.ImageView[@resource-id="com.app.instavolt:id/ivIcon"])[2]
#    Run Keyword If    '${marketing_preferences}' == 'True' and '${USER_CHOICE}' == 'No'     Click Element    xpath=(//android.widget.ImageView[@resource-id="com.app.instavolt:id/ivIcon"])[3]
#    Click Element    com.app.instavolt:id/btnNext


#Verify Tutorial Screen OLD     # This seems like more of a test case than a keyword so I may break this down.
#    [Documentation]     Navigates through each page of the tutorial screen, capturing screenshots of each view.
#    Wait Until Page Contains    Tutorial
#    Page Should Contain Text    Welcome
#    Page Should Contain Element    com.app.instavolt:id/txtSkip
#    Capture Page Screenshot     Tutorial_Screen_1_Welcome.png
#    Click Tutorial Next Button
#    Page Should Contain Text    HOW TO CHARGE
#    Page Should Contain Text    Find a charger
#    Page Should Contain Element    com.app.instavolt:id/txtSkip
#    Capture Page Screenshot     Tutorial_Screen_2_Find_A_Charger.png
#    Click Tutorial Next Button
#    Page Should Contain Text    HOW TO CHARGE
#    Page Should Contain Text    Start your charge
#    Page Should Contain Element    com.app.instavolt:id/txtSkip
#    Capture Page Screenshot     Tutorial_Screen_3_Start_Your_Charge.png
#    Click Tutorial Next Button
#    Page Should Contain Text    HOW TO CHARGE
#    Page Should Contain Text    Plugging in
#    Page Should Contain Element    com.app.instavolt:id/txtSkip
#    Capture Page Screenshot     Tutorial_Screen_4_Plugging_In.png
#    Click Tutorial Next Button
#    Page Should Contain Text    Rewards
#    Page Should Contain Text    Earn rewards as you charge
#    Page Should Contain Element    com.app.instavolt:id/txtSkip
#    Page Should Contain Element    com.app.instavolt:id/btnGetStarted
#    Page Should Not Contain Element    com.app.instavolt:id/txtNext     # Next button should not be visible on this page
#    Capture Page Screenshot     Tutorial_Screen_5_Rewards.png
#    # click indicators at bottom 5 times, verify text on each page only (loop)
#    Click Tutorial Page Number    1
#    Page Should Contain Text    Welcome
#    Page Should Contain Element    com.app.instavolt:id/txtSkip
#    Click Tutorial Page Number    2
#    Page Should Contain Text    HOW TO CHARGE
#    Page Should Contain Text    Find a charger
#    Page Should Contain Element    com.app.instavolt:id/txtSkip
#    Click Tutorial Page Number    3
#    Page Should Contain Text    HOW TO CHARGE
#    Page Should Contain Text    Start your charge
#    Page Should Contain Element    com.app.instavolt:id/txtSkip
#    Click Tutorial Page Number    4
#    Page Should Contain Text    HOW TO CHARGE
#    Page Should Contain Text    Plugging in
#    Page Should Contain Element    com.app.instavolt:id/txtSkip
#    Click Tutorial Page Number    5
#    Page Should Contain Text    Rewards
#    Page Should Contain Text    Earn rewards as you charge
#    Page Should Contain Element    com.app.instavolt:id/txtSkip
#    Page Should Not Contain Element    com.app.instavolt:id/txtNext
#    Click Tutorial Get Started Button
#    # Confirm I'm on find a charger screen
#    Current Screen Should be Find a Charger
#    # Navigate back to tutorial page, click next once, then skip
#    Click Hamburger Menu on Find a Charger Screen
#    Click Tutorial
#    Click Tutorial Next Button
#    Click Tutorial Skip Button
#    # Confirm I'm on find a charger screen
#    Current Screen Should be Find a Charger

#Verify Tutorial Screen 1 Content
#    [Documentation]     Verify Tutorial screen 1 content and capture screenshot
#    Page Should Contain Text    Welcome
#    Page Should Contain Element    com.app.instavolt:id/txtSkip
#    Capture Page Screenshot     Tutorial_Screen_1_Welcome.png
#
#Verify Tutorial Screen 2 Content
#    [Documentation]     Verify Tutorial screen 2 content and capture screenshot
#    Page Should Contain Text    HOW TO CHARGE
#    Page Should Contain Text    Find a charger
#    Page Should Contain Element    com.app.instavolt:id/txtSkip
#    Capture Page Screenshot     Tutorial_Screen_2_Find_A_Charger.png
#
#Verify Tutorial Screen 3 Content
#    [Documentation]     Verify Tutorial screen 3 content and capture screenshot
#    Page Should Contain Text    HOW TO CHARGE
#    Page Should Contain Text    Start your charge
#    Page Should Contain Element    com.app.instavolt:id/txtSkip
#    Capture Page Screenshot     Tutorial_Screen_3_Start_Your_Charge.png
#
#Verify Tutorial Screen 4 Content
#    [Documentation]     Verify Tutorial screen 4 content and capture screenshot
#    Page Should Contain Text    HOW TO CHARGE
#    Page Should Contain Text    Plugging in
#    Page Should Contain Element    com.app.instavolt:id/txtSkip
#    Capture Page Screenshot     Tutorial_Screen_4_Plugging_In.png
#
#Verify Tutorial Screen 5 Content
#    [Documentation]     Verify Tutorial screen 5 content and capture screenshot
#    Page Should Contain Text    Rewards
#    Page Should Contain Text    Earn rewards as you charge
#    Page Should Contain Element    com.app.instavolt:id/txtSkip
#    Page Should Contain Element    com.app.instavolt:id/btnGetStarted
#    Page Should Not Contain Element    com.app.instavolt:id/txtNext     # Next button should not be visible on this page
#    Capture Page Screenshot     Tutorial_Screen_5_Rewards.png