from appium import webdriver


def initialize_driver_emulator():
    capabilities = {
        "platformName": "Android",
        "automationName": "uiautomator2",
        "deviceName": "emulator-5554",
        "appPackage": "com.app.instavolt",
        "appActivity": "com.app.instavolt.ui.splash.SplashActivity",
        "language": "en",
        "locale": "GB",
        "appium:settings[waitForIdleTimeout]": 100,
    }
    driver = webdriver.Remote('http://localhost:4723', capabilities)
    return driver
