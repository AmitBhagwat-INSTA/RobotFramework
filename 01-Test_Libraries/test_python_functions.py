import os
from selenium import webdriver

def open_browser_with_url_and_close(browser, url):
    try:
        if browser.lower() == "chrome":
            driver = webdriver.Chrome()
        elif browser.lower() == "firefox":
            driver = webdriver.Firefox()
        else:
            raise ValueError(f"Unsupported browser: {browser}")

        driver.get(url)
    except Exception as e:
        print(f"Error: {e}")
    finally:
        try:
            driver.quit()
        except NameError:
            pass

def click_button_by_name(button_name):
    button_name.click()

def Unzip_Zip_File(ZipFile):
    os.system("unzip -o " + ZipFile)
    return True
