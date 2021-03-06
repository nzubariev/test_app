module TestApp
  class Webdriver

    include Logger

    attr_reader :driver

    DEFAULT_BROWSER = :firefox
    DEFAULT_WEBDRIVER_TIMEOUT = 10
    BASE_URL = 'https://www.upwork.com'

    def initialize(browser = nil)
      logger.info('Setup webdriver...')
      @driver = if browser.nil?
                  Selenium::WebDriver.for DEFAULT_BROWSER
                else
                  Selenium::WebDriver.for browser.to_sym
            end
      @driver.manage.timeouts.implicit_wait = DEFAULT_WEBDRIVER_TIMEOUT
      @driver.manage.window.maximize
      clear_cookie
      go_to_start_page
    end

    def go_to_start_page
      logger.info('Go to start page!')
      driver.navigate.to(BASE_URL)
    end

    def clear_cookie
      logger.info('Clear browser cookie...')
      driver.manage.delete_all_cookies
    end

    def stop
      logger.info('Stop webdriver. Happy end :)')
      driver.quit
    end
  end
end