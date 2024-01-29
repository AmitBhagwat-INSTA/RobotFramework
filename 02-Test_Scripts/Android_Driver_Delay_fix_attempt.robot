*** Settings ***

Library     AppiumLibrary
Library     ../01-Test_Libraries/appium_funtions.py

Resource       ../01-Test_Libraries/Android_Keywords.resource
Variables      ../01-Test_Libraries/android_test_variables.py

*** Test Cases ***

Android-Driver-Login-01 1.1 - Open Instavolt Driver Application
    Open Instavolt Driver Application To Splash Screen On Device    ${ANDROID_DEVICE_NAME}
    #Initialize Driver Emulator
    Sleep   5s
#    Login To Android Driver App As Non Federated User    ${OLI_USERNAME}    ${OLI_PASSWORD}
#    Sleep    10s
    #Wait Until Element Is Visible    id=com.app.instavolt:id/btnSignIn
Android-Driver - Sign in
    #Click Element    id=com.app.instavolt:id/btnSignIn  # Fails because no applicaiton is open...
                                                        # how do i pass settings to open browesr keyword???
    Login To Android Driver App As Non Federated User    ${OLI_USERNAME}    ${OLI_PASSWORD}
    Sleep    5s
    
Android-Driver - Try reduce resolve marketing pref time
    Resolve Marketing Preferences Page    No
    Sleep    10s

#Android-Driver-Login-01 1.2 - Login
#    Login To Android Driver App As Non Federated User    ${OLI_USERNAME}    ${OLI_PASSWORD}
#    #Sleep    3s
#    #Resolve Premium Service Popup    ${MAYBE_LATER_ELEMENT}
#    Sleep    8s
#    Resolve Marketing Preferences Page    No  # Clicking Yes/No and Next takes a very long time ~40s each, ~80s total...
#                                              # perhaps I should try writing this in raw appium code? I'm convinced the rf keywords themselves should be fine...
#                                              # Perhaps raw appium code might help, although I'd still be using same appium and driver versions...
#                                              # Try disable animations on physical pixel 7a?
#                                              # Appium and ui2automator are up to date as of 18/01/24...
#    Click Element    com.app.instavolt:id/txtSkip   # CLicking Skip takes a very long time ~31s... This should be a 'resolve tutorial page' keyword
#    Sleep    2s
#    Resolve Location Access Popup    Only this time
#    #Sleep    6s
#
#Android-Driver-Login-01 1.3 - Open Station Detail Page
#    #Navigate to Charging Station from List Button    Aberdeen, UK
#    Navigate to Charging Station from List Button   # This keyword is static, it just takes me to first station result from the list...
#
#Android-Driver-Login-01 1.4 - Close the Application
#    Close Application

