require "ruby_appianautomation/version"
=begin
Appian Ruby Test Automation Framework version v.0.0.1, all the methods are defined below and can be used for automation appian based applications
these methods are only Appian specific and can't be used for any other platform.
=end

require 'selenium-webdriver'
require 'cucumber'
require 'rubygems'
require 'csv' # gem used to deal with csv files
require 'resolv' # gem used to deal with email validations
require 'rspec'

#################################################### Generic Declartions of constants #####################################################################
TEXT ||=1
PICKER_FIELD ||=2
RADIO_BUTTON ||=3
DROP_DOWN ||=4
DATE_FIELD ||= 5
BUTTON ||=6
PARAGRAPH ||= 7
UPLOAD_FIELD ||=8  ######## || is used to remove already used warnings from the console ###########
$option = Array(1..10)
$address_option = Array(1..10)
module RubyAppianautomation
  # Your code goes here...

  
  ############################## Ruby Module Starts from here ####################################
  
    appian_xpath = CSV.read('C:\Users\Appcino\Desktop\xpath_details.csv', :headers=>true)
    field_name = appian_xpath['Xpath']
    $xpath_username = field_name[0]
    $xpath_password = field_name[1]
    $xpath_signin = field_name[2]
    $xpath_navigation = field_name[3]
    $xpath_radiobutton = field_name[4]
    $xpath_textfield = field_name[5]
    $xpath_pickerfield = field_name[6]
    $xpath_pickdata = field_name[7]
    $xpath_dropdownfield = field_name[8]
    $xpath_pickdropdown = field_name[9]
    $xpath_datefield = field_name[10]
    $xpath_uploadfield = field_name[11]
    $xpath_errorupload = field_name[12]
    $xpath_emailvalidation = field_name[13]
    $xpath_emailvalidationerror = field_name[14]
    $xpath_phonevalidation = field_name[15]
    $xpath_phonevalidationerror = field_name[16]
    $xpath_charvalidationtextarea = field_name[17]
    $xpath_charvalidationtext = field_name[18]
    $xpath_charvalidationerror = field_name[19]
    $xpath_dateerror = field_name[20]
    # puts $xpath_password
    #############################################################################################################################################
  
  ################################################ Method for Login In Appian #################################################################
  
      def RubyForAppian.logininappian(url, username, password, driver)
        driver.navigate.to url
        driver.manage.window.maximize
  
        driver.find_element(:xpath, $xpath_username).send_keys username
        driver.find_element(:xpath, $xpath_password).send_keys password
        driver.find_element(:xpath, $xpath_signin).click
      end
  
  ###########################################################################################################################################
  
  
  
  ############################################## Method for Navigate in Appian Tempo ########################################################
  
      
  ###########################################################################################################################################


end
