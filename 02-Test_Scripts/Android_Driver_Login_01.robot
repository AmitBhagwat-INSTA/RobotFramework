*** Settings ***

Library     AppiumLibrary   timeout=10
                            # Sometimes, pages take longer than 5s to load, so default timeout (5s) has been increased
Library     ../01-Test_Libraries/api_calls.py

Resource       ../01-Test_Libraries/Android_Keywords.resource
Variables      ../01-Test_Libraries/android_test_variables.py

*** Test Cases ***

Android-Driver-Login-01 1.1 - Open Instavolt Driver Application
    Open Instavolt Driver Application To Splash Screen On Device    ${ANDROID_DEVICE_NAME}

Android-Driver-Login-01 1.2 - Login
    Login To Android Driver App As Non Federated User    ${OLI_USERNAME}    ${OLI_PASSWORD}
    #Sleep    3s
    #Resolve Premium Service Popup    MAYBE LATER
    #Sleep    8s
    Resolve Marketing Preferences Page    No  # Make sure to set waitForIdleTimeout to ~100 otherwise clicking
                                              # 'Yes/No' and 'Next' takes a very long time ~40s each, ~80s total...
    Click Element    com.app.instavolt:id/txtSkip   # This should porbably be a 'resolve tutorial page' keyword
    Sleep    2s
    Resolve Location Access Popup    Only this time
    
Android-Driver-Login-01 1.3 - Open Station Detail Page
    #Navigate to Charging Station from List Button    Aberdeen, UK
    Navigate to Charging Station from List Button   # This keyword is static, it just takes me to first station result from the list...
    Resolve Charge Station Numbering Popup      Show next time
    Sleep   3s

Android-Driver-Login-01 1.4 - Perform Charge
    Slide to Charge
    Resolve All Pre-Charge Scenerios    # Need to have some kind of loop happening until I reach either start charge screen OR the actual charging screen
    #Perform Full Charge

Android-Driver-Login-01 1.5 - Close the Application
    Close Application

