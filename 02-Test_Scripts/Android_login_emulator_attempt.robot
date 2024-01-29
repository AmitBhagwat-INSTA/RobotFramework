*** Settings ***

Library     AppiumLibrary

*** Test Cases ***
Open_Application
    Open Application    http://localhost:4723/wd/hub    platformName=Android    deviceName=emulator-5554    appPackage=com.app.instavolt    appActivity=com.app.instavolt.ui.login.AuthActivity     automationName=UiAutomator2