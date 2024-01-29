from selenium import webdriver


class MySeleniumLibrary:
    def __init__(self, browser='chrome'):
        if browser.lower() == 'chrome':
            self.driver = webdriver.Chrome()
        elif browser.lower() == 'firefox':
            self.driver = webdriver.Firefox()
        else:
            raise ValueError("Invalid browser specified. Supported browsers are 'chrome' or 'firefox'.")

    def open_browser_selenium(self, url):
        self.driver.get(url)

    def click_element(self, locator):
        element = self.driver.find_element(*locator)
        element.click()

    def close_browser(self):
        self.driver.quit()
