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
  
      def RubyForAppian.navigate(link_name, action, driver)
        # puts link_name
        # puts $xpath_navigation
        xpath_name = $xpath_navigation.gsub("+link_name+", link_name).gsub!('"', '')
        # puts xpath_name
        if action == 'click'
          driver.find_element(:xpath, xpath_name).click
  
        elsif action == 'enter'
          driver.find_element(:xpath, xpath_name).send_keys :return
  
        elsif action == 'sendkeys'
  
        end
  
      end
  
  #############################################################################################################################################
  
  
  ############################################### Method for selecting option in Radio Button field ##############################################
  
  
      def RubyForAppian.select_option(label,action,field_type,data, option, driver)
        # xpath_radio = "//label[contains(text(), '"+label_name+"']"
        xpath_radio =  $xpath_radiobutton.gsub("+label+", label).gsub('"','')
        if action == 'click'
          driver.find_element(:xpath, xpath_radio).click
        elsif action == 'enter'
          driver.find_element(:xpath , xpath_radio).sendkeys :return
        elsif action == 'sendkeys'
          driver.find_element(:xpath, xpath_radio).sendkeys data
        end
        # driver.find_element(:xpath, xpath_radio).sendkeys option
  
      end
  
  #############################################################################################################################################
  
  ##################################### Method for clicking, selecting or sending data in any Appian web element ##############################
  
      def RubyForAppian.element(label,action, field_type, data,option , driver)
        # xpath_name = "//label[contains(text(), '"+label+"')]"
  
        # If element is text field
  
        if field_type == TEXT
          xpath_input = $xpath_textfield.gsub("+label+", label).gsub('"','')
          if action == 'click'
            driver.find_element(:xpath, xpath_input).click
          elsif action == 'enter'
            driver.find_element(:xpath, xpath_input).send_keys :return
          elsif action == 'sendkeys'
            driver.find_element(:xpath, xpath_input).send_keys data
          end
        elsif field_type == RADIO_BUTTON   # If element is radio button
          RubyForAppian.select_option(label,action, field_type,data ={},option = {}, driver)
        elsif field_type == PICKER_FIELD    # If element is picker field
          xpath_input = $xpath_pickerfield.gsub("+label+", label).gsub('"','')
          driver.find_element(:xpath, xpath_input).send_keys data
          sleep(3)
          driver.find_element(:xpath, $xpath_pickdata.gsub("+data+",data).gsub('"','')).click
        elsif field_type == PARAGRAPH
          xpath_input = "//label[contains(text(), '"+label+"')]/../..//textarea"
          # If user wants to click
  
          if action == 'click'
            driver.find_element(:xpath, xpath_input).click
          end
          # If user wants to simulate enter key press
          if action == 'enter'
            driver.find_element(:xpath, xpath_input).send_keys :return
          end
          # If user wants to populate the field
          if action == 'sendkeys'
            driver.find_element(:xpath, xpath_input).send_keys data
          end
          # If element is dropdown field
        elsif field_type == DROP_DOWN
          xpath_input = "//span[contains(text(), '"+label+"')]/../..//select"
          # xpath_input = "//span[contains(text(), '"+label+"')]/../..//option[contains(text(), '"+option+"')]"
          if action == 'click'
            driver.find_element(:xpath, xpath_input).click
          elsif action == 'enter'
            driver.find_element(:xpath, xpath_input).send_keys :return
          elsif action == 'sendkeys'
            driver.find_element(:xpath, xpath_input).send_keys data
            sleep(2)
          end
  
          # If element is date field
  
        elsif field_type == DATE_FIELD
          xpath_input = $xpath_datefield.gsub("+label+", label).gsub('"','')
          # xpath_input = "//label[contains(text(), '"+label+"')]/../..//input[@aria-invalid='false']"
  
          # If user wants to click on the field
          if action == 'click'
            driver.find_element(:xpath, xpath_input).click
            # If user wants to simulate enter key press on the field
          elsif action == 'enter'
            driver.find_element(:xpath, xpath_input).send_keys :return
            # If user wants to send data in field
          elsif action == 'sendkeys'
            dateFieldId = driver.find_element(:xpath, xpath_input).attribute("id")
            print dateFieldId
            driver.execute_script("document.getElementById('"+dateFieldId+"').focus()")
            driver.find_element(:id, dateFieldId).send_keys data
            driver.execute_script("document.getElementById('"+dateFieldId+"').blur()")
          end
  
          # Code for upload field
        elsif field_type == UPLOAD_FIELD
          xpath_input = $xpath_uploadfield.gsub("+label+", label).gsub('"','')
          xpath_error = $xpath_errorupload.gsub("+label+", label).gsub('"','')
          #xpath_input = "//label[contains(text(), '"+label+"')]/../..//input[@class='gwt-FileUpload']"
          #xpath_error = "//label[contains(text(), '"+label+"')]/../..//p[@class='component_error']"
          if action == 'click'
            driver.find_element(:xpath, xpath_input).click
          elsif action == 'enter'
            driver.find_element(:xpath, xpath_input).send_keys :return
          elsif action == 'sendkeys'
            driver.find_element(:xpath, xpath_input).send_keys data
            filename = data
            #if filename !~ /.(png|PNG|jpg|JPG|jpeg|JPEG)/ # This is for the image file upload validation
              #begin
                #error_element = driver.find_element(:xpath, xpath_error).displayed?
              #rescue
                #puts error_element
              #end
              #if error_element == true
                # expect(error_element).to be true
                #puts "invalid NOT AN IMAGE FILE"
              #else
                # expect(error_element).to be true
                #puts "invalid NOT AN IMAGE FILE"
              #end
            #end
          end
        end
      end
  
    # Method for email validation
  
    def RubyForAppian.email_validation(label,driver)
      number = rand(1...2)
      males = ["tom"]
      females = ["elizabeth"]
  
      surnameMales = ["oak" ]
      surnameFemales = ["rosewelth"]
  
      providers = ["gmail.com", "hotmail.com", "yahoo.co.in"]
  
      providers_invalid = ["gmail..com","@hotmail.com","yahoo.co.in"]
      # This loop is generating valid email addresses
      address = []
      providers.each do |addresses|
        addresses = "#{ males.sample }.#{ surnameMales.sample }#{ number }@#{ providers.sample }"
        address << addresses
      end # loop ends here
      puts address[0]
      # This loop is generating invalid email addresses
      invalid_address = []
      providers_invalid.each do |invalid_addresses|
        invalid_addresses = "#{males.sample}_#{surnameMales.sample}#{number}@#{providers_invalid.sample}"
        invalid_address <<  invalid_addresses
      end # loop ends here
      
      #xpath_input = "//label[contains(text(),'"+label+"')]/../..//input"
      xpath_input = $xpath_emailvalidation.gsub("+label+", label).gsub('"','')
      email_field = driver.find_element(:xpath, xpath_input).attribute("id")
  
      original_element = driver.find_element(:xpath, xpath_input)
      driver.execute_script("document.getElementById('"+email_field+"').focus()") # sending a valid email address as expected
      original_element.send_keys address[0]
      driver.execute_script("document.getElementById('"+email_field+"').blur()")
  
      #xpath_error = "//label[contains(text(), '"+label+"')]/../..//p[@class='component_error']"
      xpath_error = $xpath_emailvalidationerror.gsub("+label+", label).gsub('"','')
      begin
        error_element = driver.find_element(:xpath, xpath_error).displayed?
      rescue
        puts error_element
      end
      puts error_element
      if error_element == true
        # expect(error_element).to be true
        puts "invalid"
      else
        puts "valid"
      end
      driver.find_element(:xpath, xpath_input).clear() # sending a valid email address as expected
      driver.find_element(:xpath, xpath_input).send_keys address[1]
  
      begin
        error_element = driver.find_element(:xpath, xpath_error).displayed?
      rescue
        puts error_element
      end
      puts error_element
      if error_element == true
        # expect(error_element).to be true
        puts "invalid"
      else
        puts "valid"
      end
      driver.find_element(:xpath, xpath_input).clear()
      driver.find_element(:xpath, xpath_input).send_keys address[2]
      # driver.execute_script("document.getElementById('"+email_field+"').focus()") # sending a valid email address as expected
      begin
        error_element = driver.find_element(:xpath, xpath_error).displayed?
      rescue
        puts error_element
      end
      puts error_element
      if error_element == true
        # expect(error_element).to be true
        puts "invalid"
      else
        puts "valid"
      end
      driver.find_element(:xpath, xpath_input).clear()
  
      # Now passing invalid email addresses one by one
  
      # driver.execute_script("document.getElementById('"+email_field+"').focus()")
      driver.find_element(:xpath, xpath_input).send_keys invalid_address[0]  # passing the invalid email address
      # driver.execute_script("document.getElementById('"+email_field+"').blur()")
      begin
        error_element = driver.find_element(:xpath, xpath_error).displayed?
      rescue
        puts error_element
      end
      puts error_element
      if error_element == true
        # expect(error_element).to be true
        puts "invalid"
      else
        # expect(error_element).to be true
        puts "invalid"
      end
  
      # driver.execute_script("document.getElementById('"+email_field+"').focus()")
      driver.find_element(:xpath, xpath_input).clear()
      driver.find_element(:xpath, xpath_input).send_keys invalid_address[1]  # passing the invalid email address
      # driver.execute_script("document.getElementById('"+email_field+"').blur()")
      begin
        error_element = driver.find_element(:xpath, xpath_error).displayed?
      rescue
        puts error_element
      end
      puts error_element
      if error_element == true
        # expect(error_element).to be true
      else
        # expect(error_element).to be true
      end
      # driver.execute_script("document.getElementById('"+email_field+"').focus()")
      driver.find_element(:xpath, xpath_input).clear()
      driver.find_element(:xpath, xpath_input).send_keys invalid_address[2]  # passing the invalid email address
      # driver.execute_script("document.getElementById('"+email_field+"').blur()")
      begin
        error_element = driver.find_element(:xpath, xpath_error).displayed?
      rescue
        puts error_element
      end
      puts error_element
      if error_element == true
        # expect(error_element).to be true
        puts "invalid"
      else
        # expect(error_element).to be true
        puts "invalid"
      end
      
    end
  
  
  # This is a method for phone number field validation
  
    def RubyForAppian.phone_validation(label,chars,driver)
      #xpath_input = "//label[contains(text(),'"+label+"')]/../..//input"
      xpath_input =  $xpath_phonevalidation.gsub("+label+", label).gsub('"','')
      phone_field =  driver.find_element(:xpath, xpath_input).attribute("id")
      puts phone_field
      phone_string = rand(chars-1 ** chars-1).to_s.rjust(chars-1,'0')
      puts phone_string
      original_element = driver.find_element(:xpath, xpath_input)
  
      original_element.send_keys phone_string # sending phone no with chars less than one as passed
      #xpath_error = "//label[contains(text(), '"+label+"')]/../..//p[@class='component_error']"
      xpath_error =  $xpath_emailvalidationerror.gsub("+label+", label).gsub('"','')
      begin
        error_element = driver.find_element(:xpath, xpath_error).displayed?
      rescue
        puts error_element
      end
      if error_element == true
        puts "valid"
      else
        # expect(error_element).to be true
        puts "invalid "
      end
      $increment = Array(0..1)
      original_element.send_keys "#{$increment[0]}" # sending phone no with one char more then passed
      begin
        error_element = driver.find_element(:xpath, xpath_error).displayed?
      rescue
        puts error_element
      end
      if error_element == true
        puts "valid"
      else
        # expect(error_element).to be true
        puts "invalid"
      end
      original_element.send_keys "#{$increment[1]}"
      begin
        error_element = driver.find_element(:xpath, xpath_error).displayed?
      rescue
        puts error_element
      end
      if error_element.nil?
        puts "valid"
      else
        puts "invalid"
      end
      original_element.send_keys "#{$increment[0]}"
      begin
        error_element = driver.find_element(:xpath, xpath_error).displayed?
        puts error_element
      rescue
        puts error_element
      end
      if error_element == true
        puts "valid"
      else
        # expect(error_element).to be true
        puts "invalid"
      end
      original_element.clear()
      o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
      phone_string = (0...chars-1).map { o[rand(o.length)] }.join
  
      original_element.send_keys phone_string # sending string of characters
      begin
        error_element = driver.find_element(:xpath, xpath_error).displayed?
        puts error_element
      rescue
        puts error_element
      end
     
      if error_element == true
        puts "invalid"
        # expect(error_element).to be true
      else
        # expect(error_element).to be true
        puts "invalid"
      end
    end
  
    # This method is to click on submit button
    def RubyForAppian.click_on_submit(label,data,driver)
      xpath_input = "//button[contains(text(), 'Submit')]"
      driver.find_element(:xpath, xpath_input).click
    end
  
  
    # For validating the number of char allowed in an input or paragraph field
  
    def RubyForAppian.char_validation(label,field_type,chars,driver)
      o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
      string = (0...chars-1).map { o[rand(o.length)] }.join  # Generating random string of characters
      string_length =string.length
      puts string_length
  
      if field_type == PARAGRAPH
        xpath_input = $xpath_charvalidationtextarea.gsub("+label+", label).gsub('"','')
        #xpath_input = "//label[contains(text(), '"+label+"')]/../..//textarea"
      elsif field_type == TEXT
        #xpath_input = "//label[contains(text(), '"+label+"')]/../..//input"
        xpath_input = $xpath_charvalidationtext.gsub("+label+", label).gsub('"','')
      end
      textareaFieldId = driver.find_element(:xpath, xpath_input).attribute("id")
  
      original_element = driver.find_element(:xpath, xpath_input)
      # valid cases for characters
  
      $increment = Array(0..1)
      #xpath_error = "//label[contains(text(), '"+label+"')]/../..//p[@class='component_error']"
      xpath_input = $xpath_charvalidationerror.gsub("+label+", label).gsub('"','')
  
      driver.execute_script("document.getElementById('"+textareaFieldId+"').focus()") # sending one char less then excepted
      original_element.send_keys string
      driver.execute_script("document.getElementById('"+textareaFieldId+"').blur()")
      begin
        error_element = driver.find_element(:xpath, xpath_error).displayed?
      rescue
        puts error_element
      end
      if error_element.nil?
        puts "valid"
      else
        puts "invalid"
      end
      driver.execute_script("document.getElementById('"+textareaFieldId+"').focus()") # sending same no of characters as accepted
      original_element.send_keys "#{$increment[0]}"
      driver.execute_script("document.getElementById('"+textareaFieldId+"').blur()")
      begin
        error_element = driver.find_element(:xpath, xpath_error).displayed?
      rescue
        puts error_element
      end
      if error_element == true
        puts "valid"
      else
        # expect(error_element).to be true
        puts "invalid"
      end
      driver.execute_script("document.getElementById('"+textareaFieldId+"').focus()") # sending one char more then excepted in that case test case will fail
      original_element.send_keys "#{$increment[1]}"
      driver.execute_script("document.getElementById('"+textareaFieldId+"').blur()")
      begin
        error_element = driver.find_element(:xpath, xpath_error).displayed?
        puts error_element
      rescue
        puts error_element
      end
      # expect(error_element).to be (true)
       if error_element == true
         # expect(error_element).to be true
         puts "invalid"
       else
         # expect(error_element).to be true
         puts "invalid"
       end
    end
  
    # This method is used for past and future date validation
    def RubyForAppian.date_validation(label,date_time,driver)
      date_today = Time.now.strftime("%m/%d/%Y")
      puts date_today
      now = Time.new()
      now_day = Time.now.strftime('%d').to_i
      now_year = Time.now.strftime('%y').to_i
      now_month = Time.now.strftime('%m').to_i
      future_month = now_month + 2
      past_month = now_month - 1
      puts future_month
      date_future = Time.now.strftime("#{future_month}/#{now_day}/#{now_year}")
      date_past = Time.now.strftime("#{past_month}/#{now_day}/#{now_year}")
      
      #xpath_input  = "//label[contains(text(), '"+label+"')]/../..//input[@aria-invalid='false']"
      xpath_input = $xpath_datefield.gsub("+label+", label).gsub('"','')
      original_element = driver.find_element(:xpath, xpath_input )
      dateFieldId = driver.find_element(:xpath, xpath_input).attribute("id")
      puts dateFieldId
      #xpath_error = "//label[contains(text(), '"+label+"')]/../..//p[@class='component_error']"
      xpath_error = $xpath_dateerror.gsub("+label+", label).gsub('"','')
      if date_time == "past" # when date field has validation on future dates
        driver.execute_script("document.getElementById('"+dateFieldId+"').focus()")
        driver.find_element(:id, dateFieldId).send_keys date_today
        driver.execute_script("document.getElementById('"+dateFieldId+"').blur()")
        begin
          error_element = driver.find_element(:xpath, xpath_error).displayed?
        rescue
          puts error_element
        end
        if error_element == true
          # expect(error_element).to be true
          puts "invalid"
        else
          puts "valid"
        end
        driver.find_element(:id, dateFieldId).clear()
        driver.execute_script("document.getElementById('"+dateFieldId+"').focus()")
        driver.find_element(:id, dateFieldId).send_keys date_past
        driver.execute_script("document.getElementById('"+dateFieldId+"').blur()")
        begin
          error_element = driver.find_element(:xpath, xpath_error).displayed?
        rescue
          puts error_element
        end
        if error_element == true
          # expect(error_element).to be true
          puts "invalid"
        else
          puts "valid"
        end
        driver.find_element(:id, dateFieldId).clear()
        driver.execute_script("document.getElementById('"+dateFieldId+"').focus()")
        driver.find_element(:id, dateFieldId).send_keys date_future
        driver.execute_script("document.getElementById('"+dateFieldId+"').blur()")
        begin
          error_element = driver.find_element(:xpath, xpath_error).displayed?
        rescue
          puts error_element
        end
        if error_element == true
          # expect(error_element).to be true
          puts "invalid"
        else
          # expect(error_element).to be true
          puts "invalid"
        end
        # driver.find_element(:id, dateFieldId).clear()
        if date_time == "future" # when date field has validation on past dates
          driver.execute_script("document.getElementById('"+dateFieldId+"').focus()")
          driver.find_element(:id, dateFieldId).send_keys date_today
          driver.execute_script("document.getElementById('"+dateFieldId+"').blur()")
          begin
            error_element = driver.find_element(:xpath, xpath_error).displayed?
          rescue
            puts error_element
          end
          if error_element == true
            # expect(error_element).to be true
            puts "invalid"
          else
            puts "valid"
          end
          driver.find_element(:id, dateFieldId).clear()
          driver.execute_script("document.getElementById('"+dateFieldId+"').focus()")
          driver.find_element(:id, dateFieldId).send_keys date_past
          driver.execute_script("document.getElementById('"+dateFieldId+"').blur()")
          begin
            error_element = driver.find_element(:xpath, xpath_error).displayed?
          rescue
            puts error_element
          end
          if error_element == true
            # expect(error_element).to be true
            puts "invalid"
          else
            # expect(error_element).to be true
            puts "invalid"
          end
          driver.find_element(:id, dateFieldId).clear()
          driver.execute_script("document.getElementById('"+dateFieldId+"').focus()")
          driver.find_element(:id, dateFieldId).send_keys date_future
          driver.execute_script("document.getElementById('"+dateFieldId+"').blur()")
          begin
            error_element = driver.find_element(:xpath, xpath_error).displayed?
          rescue
            puts error_element
          end
          if error_element == true
            # expect(error_element).to be true
            puts "invalid"
          else
            puts "valid"
          end
        end
  
      end
    end
  
    # This method is used for database validation if the data is getting submitted in database or not
    def RubyForAppian.database_validation(driver)
  
    end
  ###########################################################################################################################################


end
