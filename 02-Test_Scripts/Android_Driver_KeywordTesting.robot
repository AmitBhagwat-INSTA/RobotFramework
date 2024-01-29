*** Settings ***

Library     AppiumLibrary   timeout=15
                            # Sometimes, pages take longer than 5s to load, so default timeout (5s) has been increased
Library     ../01-Test_Libraries/api_calls.py

Resource       ../01-Test_Libraries/Android_Keywords.resource
Variables      ../01-Test_Libraries/android_test_variables.py

*** Test Cases ***

Android-Driver-Keyword-Testing 1.1 - Open Instavolt Driver Application
    Open Instavolt Driver Application To Splash Screen On Device    ${ANDROID_DEVICE_NAME}

Android-Driver-Keyword-Testing 1.2 - Login
    #Login To Android Driver App As Non Federated User    ${OLI_USERNAME}    ${OLI_PASSWORD}
    #Login to Android Driver App As Facebook User
    Sign Up To Android Driver App As Facebook User
    Resolve Facebook Popup      Continue
    #Sleep    3s
    #Resolve Premium Service Popup    MAYBE LATER
    #Sleep    8s
    Resolve Marketing Preferences Page    No  # Make sure to set waitForIdleTimeout to ~100 otherwise clicking
                                              # 'Yes/No' and 'Next' takes a very long time ~40s each, ~80s total...
    #Click Element    com.app.instavolt:id/txtSkip   # This should porbably be a 'resolve tutorial page' keyword
    Click Tutorial Skip Button
    Resolve Location Access Popup    Only this time
    
Android-Driver-Keyword-Testing
    Click Hamburger Menu on Find a Charger Screen
    Click About
    Verify About Screen Version Number    3.0.0
    #Click FAQ's
    #Verify Tutorial Screens and Buttons
    #Verify Question Collapse Behaviour
    #Verify Question Expanding Behaviour
    #Verify Price In FAQ Questions    ${0.85}


#Android-Driver-Keyword-Testing - Logout
#    Click Navigation Menu
#    Click Hamburger Menu on Find a Charger Screen
#    Logout    Yes

