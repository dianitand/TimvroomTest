require 'selenium-webdriver'

driver = Selenium::WebDriver.for(:chrome)

driver.get('http://timvroom.com/selenium/playground/')

# 1. Grab page title and place title text in answer slot #1
driver.find_element(:id, 'answer1').send_keys(driver.title)

# 2. Fill out name section of form to be Kilgore Trout
driver.find_element(:name, 'name').send_keys('Kilgore Trout')

# 3. Set occupation on form to Sci-Fi Author
occupation = Selenium::WebDriver::Support::Select.new(
  driver.find_element(:name, 'occupation')
)
occupation.select_by(:value, 'scifiauthor')

# 4. Count number of blue_boxes on page after form and enter into answer box #4
driver
  .find_element(:id, 'answer4')
  .send_keys(driver.find_elements(:class_name, 'bluebox').size)

# 5. Click link that says 'click me'
driver.find_element(:link_text, 'click me').click

# 6. Find red box on its page find class applied to it, and enter into answer box #6
driver
  .find_element(:id, 'answer6')
  .send_keys(driver.find_element(:id, 'redbox').attribute(:class))

# 7. Run JavaScript function as: ran_this_js_function() from your Selenium script
driver.execute_script('ran_this_js_function();')

# 8. Run JavaScript function as: got_return_from_js_function() from
#    your Selenium script, take returned value and place it in answer slot #8
driver
  .find_element(:id, 'answer8')
  .send_keys(driver.execute_script('return got_return_from_js_function();'))

# 9. Mark radio button on form for written book? to Yes
driver.find_element(:css, 'input[name="wrotebook"][value="wrotebook"]').click

# 10. Get the text from the Red Box and place it in answer slot #10
driver
  .find_element(:id, 'answer10')
  .send_keys(driver.find_element(:id, 'redbox').text)

# 11. Which box is on top? orange or green -- place correct color in answer slot #11
orangebox = driver.find_element(:id, 'orangebox')
greenbox  = driver.find_element(:id, 'greenbox')
answer11  = orangebox.location.y > greenbox.location.y ? 'green' : 'orange'
driver.find_element(:id, 'answer11').send_keys(answer11)

# 12. Set browser width to 850 and height to 650
driver.manage.window.resize_to(850, 650)

# 13. Type into answer slot 13 yes or no depending on whether item by id of ishere
#     is on the page
answer13 = driver.find_elements(:id, 'ishere').empty? ? 'no' : 'yes'
driver.find_element(:id, 'answer13').send_keys(answer13)

# 14. Type into answer slot 14 yes or no depending on whether item
#     with id of purplebox is visible
purplebox = driver.find_element(:id, 'purplebox')
answer14  = purplebox.displayed? ? 'yes' : 'no'
driver.find_element(:id, 'answer14').send_keys(answer14)

# 15. Waiting game: click the link with link text of 'click then wait' a random
#     wait will occur (up to 10 seconds) and then a new link will get added with
#     link text of 'click after wait' - click this new link within 500 ms of it
#     appearing to pass this test
wait = Selenium::WebDriver::Wait.new(timeout: 10)
driver.find_element(:link_text, 'click then wait').click
wait.until { driver.find_element(:link_text, 'click after wait').displayed? }
driver.find_element(:link_text, 'click after wait').click

# 16. Click OK on the confirm after completing task 15
driver.switch_to.alert.accept

# 17. Click the submit button on the form
driver.find_element(:id, 'submitbutton').click

# Check Results!
driver.find_element(:id, 'checkresults').click

result = driver.find_element(:id, 'showresults').text
puts result

timestamp = Time.new.strftime("%Y%m%d%H%M%S")
driver.save_screenshot("playground-result-#{timestamp}.png")

driver.quit