require 'selenium-webdriver'
require 'rubygems'
require 'rspec'

Selenium::WebDriver::Chrome.driver_path="..\\eBay\\chromedriver.exe"
driver = Selenium::WebDriver.for:chrome                                     # webdriver with chromedriver

Given("open ebay") do
  driver.navigate.to "https://www.ebay.com/"         # direct to site
  driver.manage.window.maximize
end
Then("validate website") do
    getTitle=driver.title
    puts getTitle
    expect(getTitle).to eq('Electronics, Cars, Fashion, Collectibles & More | eBay')
    sleep(2)
end
Then("login process") do
     #oturum açma işlemleri
        myEbayButton=driver.find_element(:link_text,'My eBay')
        myEbayButton.click()
        #bekleme süresi captcha testlerine denk gelme ihtimaline karşın uzatıldı
        sleep 90
        userIdText=driver.find_element(:id,"userid")
        userIdText.click()
        sleep 5
        userIdText.send_keys 'zeynepdinc.23@gmail.com'
        puts "email yazildi"
        # sleep 5
        userIdText.send_keys :enter
        puts "enter tusuna basildi"
        sleep 5
        userPassText=driver.find_element(:id,'pass')
        userPassText.click()
        sleep 5
        userPassText.send_keys 'AtLeast6'
        puts "sifre yazildi"
        #sleep 5
        userPassText.send_keys :enter
        puts "enter tusuna basildi"
        sleep 90
end

Then("validate login") do
    userName=driver.find_element(:id=>'gh-ug').text
    expect(userName).to include('zeynep')
    puts "oturum acildi ve dogrulandi"
end

Then("search product") do
    sleep 10
    #categorilere tıkla ve antikaları seç
    categorySelect=driver.find_element(:id,'gh-cat')
    categorySelect.click()
    categorySelect.send_keys :down
    categorySelect.send_keys :enter
    #aramayı başlat
    driver.find_element(:id,'gh-btn').click()
    puts "Antikalar için arama yapıldı"
    sleep 20
    driver.find_element(:xpath,'//*[@id="s0-26-9-0-1[0]-0-0-xCarousel-x-carousel-items"]/ul/li[1]/a/div/img').click()     
    puts "ilk ürün türü seçildi"   
end

Then("look at result count") do
	sleep 5
    driver.execute_script("window.scrollTo(0, 750)")
    resultText=driver.find_element(:class,'srp-controls__count-heading')
    expect(resultText.text).to include('Result')
    puts driver.find_element(:class,'srp-controls__count-heading').text
    puts "Sonuc sayisi yazildi"
           
end

Then("add and remove product")do
    driver.find_element(:xpath,'//*[@id="s0-26_2-9-0-1[0]-0-1"]/ul/li[1]/div/div[1]/div/a/div/img').click()
    puts "ilk ürün seçildi"
    sleep 10
    driver.find_element(:id,'isCartBtn_btn').click()
    puts "Urun eklendi"
    sleep 10
end

After do
    puts "test bitiriliyor"
    driver.quit()
end
