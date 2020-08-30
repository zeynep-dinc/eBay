require 'rubygems'
require 'selenium-webdriver'
require 'test/unit'
require 'cucumber'
require 'test/unit/assertions'

include Test::Unit::Assertions
    begin
    Selenium::WebDriver::Chrome.driver_path="C:\\Users\\Zeynep\\Desktop\\EbayTest\\chromedriver_85.0\\chromedriver.exe"
    driver = Selenium::WebDriver.for :chrome
    #chrome çalıştırıldı ve ebaye gidildi
    driver.get("https://www.ebay.com/")
    # set window size using Dimension struct
    driver.manage.window.maximize
    baslik=driver.title
    puts baslik
    assert_equal 'Electronics, Cars, Fashion, Collectibles & More | eBay',baslik, "sayfa acildi" 
    puts "sayfa dogru"
        #oturum açma işlemleri
        myEbayButton=driver.find_element(:link_text,'My eBay')
        myEbayButton.click()
        #bekleme süresi captcha testlerine denk gelme ihtimaline karşın uzatıldı
        sleep 90
        userIdText=driver.find_element(:id,"userid")
        userIdText.click()
        sleep 5
        userIdText.send_keys 'email.adresiniz'
        puts "email yazildi"
        # sleep 5
        userIdText.send_keys :enter
        puts "enter tusuna basildi"
        sleep 5
        userPassText=driver.find_element(:id,'pass')
        userPassText.click()
        sleep 5
        userPassText.send_keys 'Sifreniz'
        puts "sifre yazildi"
        #sleep 5
        userPassText.send_keys :enter
        puts "enter tusuna basildi"
        sleep 90
        #giriş yapılmış olması gerek fakat recaptcha ya takılma ihtimaline karşın
        userName=driver.find_element(:id=>'gh-ug').text
        puts userName+" oturum acti"
        assert_equal userName,'Hi zeynep!', "oturum acildi"
        sleep 10
            #categorilere tıkla ve antikaları seç
            categorySelect=driver.find_element(:id,'gh-cat')
            categorySelect.click()
            categorySelect.send_keys :down
            categorySelect.send_keys :enter
            #aramayı başlat
            driver.find_element(:id,'gh-btn').click()
            sleep 20
            #ürün resmine tıkla
            #driver.find_element(:id,'b-img').click()
            driver.find_element(:xpath,'//*[@id="s0-26-9-0-1[0]-0-0-xCarousel-x-carousel-items"]/ul/li[1]/a/div/img').click()
            sleep 20
            driver.execute_script("window.scrollTo(0, 750)")
            resultText=driver.find_element(:class,'srp-controls__count-heading')
            if resultText.text.include?('Result')
                puts driver.find_element(:class,'srp-controls__count-heading').text
                puts "Sonuc sayisi yazildi"
                sleep 20
                driver.find_element(:xpath,'//*[@id="s0-26_2-9-0-1[0]-0-1"]/ul/li[1]/div/div[1]/div/a/div/img').click()
                sleep 10
                driver.find_element(:id,'isCartBtn_btn').click()
                puts "Urun eklendi"
                sleep 10
                driver.find_element(:xpath,'//*[@id="mainContent"]/div/div[3]/div[1]/div/div/div[2]/div/div/div/div/div[2]/span[2]/button').click()
                puts "Urun kaldirildi"
            end
        driver.close()
    rescue Exception => e
        puts e.message
    end
