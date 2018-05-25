# Line of Credits


**Line of Credits** is an application to help the users to monitor their draw and payment activities / transaction history. Link to the application: [http://credit-test.herokuapp.com](http://credit-test.herokuapp.com/).

## Feature List

 * Display line of credits
 * Edit line of credit
 * Show line of credit
 * Add new line of credit
 * Remove line of credit
 * Save draw and payment transactions
 * Display transaction history

## Technology Used For The Automation

 * [RSpec](http://rspec.info/)
 * [Capybara](https://github.com/teamcapybara/capybara)
 * [Selenium Webdriver](https://www.seleniumhq.org/projects/webdriver)

## Test Cases
Test cases can be found in [/test_capybara/spec/requests/line_of_credits_spec.rb](https://github.com/hanselgunawan/fair-qa/blob/master/test_capybara/spec/requests/line_of_credit_spec.rb)

## How To Run The Automation

1. `git clone` this project
2. Open `terminal`
3. Do `bundle install` (if it doesn't work, do `gem install bundler` first and then execute `bundle install` once again)
4. Add your `chromedriver.exe` path to `/test_capybara/spec/rails_helper.rb`
5. Do `rails server` to start the `Puma` server
6. Open new terminal
7. Run `rspec`

## Automation Demo
[![Fair QA Automation Video](https://imgur.com/HnkISr1.png)](https://www.youtube.com/watch?v=xaDi5JMRfCI)

## Automation Report
![](https://imgur.com/vU8SL5T.pn)
![](https://imgur.com/Im90nlO.png)

## Bugs and Improvements
Here's the **Trello** link for the bugs and improvements: 

[https://trello.com/b/Z4Dvhl77/fair-project-board](https://trello.com/b/Z4Dvhl77/fair-project-board)

## Application Performance by Sitespeed.io
[Sitespeed.io](https://www.sitespeed.io) is the complete toolbox to test the web performance of your web site.
### How To Use Sitespeed.io?
Just simply execute the following command on your terminal:

`docker run --rm -v "$(pwd)":/sitespeed.io sitespeedio/sitespeed.io http://credit-test.herokuapp.com/line_of_credits -b chrome`

### Performance Report
![](https://imgur.com/IPIXh8F.png)
![](https://imgur.com/mhdqTeW.png)
![](https://imgur.com/aN4gswp.png)
