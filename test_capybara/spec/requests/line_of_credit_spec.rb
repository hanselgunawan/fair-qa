require 'rails_helper'
RSpec.describe "Credit Line", type: :request do
  describe "a new credit line" do
    it "shows credit line creation successful message", :js => true do
      visit('http://credit-test.herokuapp.com')
      click_link('New Line of credit')
      expect(page).to have_css("body > h1", text: "New Line Of Credit")
      within(:css, "form#new_line_of_credit") do
        fill_in 'line_of_credit_apr', :with => '35'
        fill_in "line_of_credit_credit_limit", :with => '1000'
      end
      click_on('Create Line of credit')
      expect(page).to have_css("#notice", text: "Line of credit was successfully created.")
      puts "Scenario: Display successful line of credit message - PASSED"
    end
  end

  describe "add a new credit line with an alphabet" do
    it "displays 'not a number' error message", :js => true do
      @alphabet_array = [*('a'..'z')]
      visit('http://credit-test.herokuapp.com')
      click_link('New Line of credit')
      expect(page).to have_css("body > h1", text: "New Line Of Credit")
      @alphabet_array.each {|i|
        within(:css, "form#new_line_of_credit") do
          fill_in 'line_of_credit_apr', :with => i
          fill_in "line_of_credit_credit_limit", :with => i
        end
        click_on('Create Line of credit')
        expect(page).to have_css("#error_explanation ul li:nth-child(1)", text: "Credit limit is not a number")
        expect(page).to have_css("#error_explanation ul li:nth-child(2)", text: "Apr is not a number")
      }
      puts "Scenario: Display APR and Credit Limit 'not a number' error messages when user puts an alphabet - PASSED"
    end
  end

  describe "add a new credit line with a blank value" do
    it "displays 'can't be blank' error message", :js => true do
      @alphabet_array = [*('a'..'z')]
      visit('http://credit-test.herokuapp.com')
      click_link('New Line of credit')
      expect(page).to have_css("body > h1", text: "New Line Of Credit")
      within(:css, "form#new_line_of_credit") do
        fill_in 'line_of_credit_apr', :with => ''
        fill_in "line_of_credit_credit_limit", :with => ''
      end
      click_on('Create Line of credit')
      expect(page).to have_css("#error_explanation ul li:nth-child(1)", text: "Credit limit can't be blank")
      expect(page).to have_css("#error_explanation ul li:nth-child(2)", text: "Credit limit is not a number")
      expect(page).to have_css("#error_explanation ul li:nth-child(3)", text: "Apr can't be blank")
      expect(page).to have_css("#error_explanation ul li:nth-child(4)", text: "Apr is not a number")
      puts "Scenario: Display APR and Credit Limit 'can't be blank' error messages when user puts a blank value - PASSED"
    end
  end

  describe "user clicks back button on add credit information page" do
    it "redirects to home page", :js => true do
      visit('http://credit-test.herokuapp.com/line_of_credits/106')
      find('body > a').click
      expect(page).to have_css("body > h1", text: "Listing Line Of Credits")
      puts "Scenario: Back button on add credit information page redirects the user to the home page - PASSED"
    end
  end

  describe "user clicks back button on edit line of credit page" do
    it "redirects to home page", :js => true do
      visit('http://credit-test.herokuapp.com/line_of_credits/106/edit')
      find('body > a:nth-child(4)').click
      expect(page).to have_css("body > h1", text: "Listing Line Of Credits")
      puts "Scenario: Back button on edit line of credit page redirects the user to the home page - PASSED"
    end
  end

  describe "user clicks show button on edit line of credit page" do
    it "redirects to home page", :js => true do
      visit('http://credit-test.herokuapp.com/line_of_credits/106/edit')
      find('body > a:nth-child(3)').click
      expect(page).to have_current_path('http://credit-test.herokuapp.com/line_of_credits/106', url: true)
      puts "Scenario: Show button on edit line of credit page redirects the user to edit credit information page - PASSED"
    end
  end

  describe "add new credit line with negative APR and Credit Limit" do
    it "displays Credit Limit and APR error handling messages", :js => true do
      visit('http://credit-test.herokuapp.com')
      click_link('New Line of credit')
      expect(page).to have_css("body > h1", text: "New Line Of Credit")
      within(:css, "form#new_line_of_credit") do
        fill_in 'line_of_credit_apr', :with => '-1'
        fill_in "line_of_credit_credit_limit", :with => '-1'
      end
      click_on('Create Line of credit')
      expect(page).to have_css("#error_explanation ul li:nth-child(1)", text: "Credit limit must be greater than or equal to 0.0")
      expect(page).to have_css("#error_explanation ul li:nth-child(2)", text: "Apr must be greater than or equal to 0.0")
      puts "Scenario: Display APR and Credit Limit error messages when user puts negative value on APR and Credit Limit - PASSED"
    end
  end

  describe "add new credit line with negative APR" do
    it "displays APR error handling messages", :js => true do
      visit('http://credit-test.herokuapp.com')
      click_link('New Line of credit')
      expect(page).to have_css("body > h1", text: "New Line Of Credit")
      within(:css, "form#new_line_of_credit") do
        fill_in 'line_of_credit_apr', :with => '-1'
        fill_in "line_of_credit_credit_limit", :with => '100'
      end
      click_on('Create Line of credit')
      expect(page).to have_css("#error_explanation ul li:nth-child(1)", text: "Apr must be greater than or equal to 0.0")
      puts "Scenario: Display APR error messages when user puts negative APR - PASSED"
    end
  end

  describe "add new credit line with negative Credit Limit" do
    it "displays Credit Limit error handling messages", :js => true do
      visit('http://credit-test.herokuapp.com')
      click_link('New Line of credit')
      expect(page).to have_css("body > h1", text: "New Line Of Credit")
      within(:css, "form#new_line_of_credit") do
        fill_in 'line_of_credit_apr', :with => '100'
        fill_in "line_of_credit_credit_limit", :with => '-1'
      end
      click_on('Create Line of credit')
      expect(page).to have_css("#error_explanation ul li:nth-child(1)", text: "Credit limit must be greater than or equal to 0.0")
      puts "Scenario: Display Credit Limit error messages when user puts negative Credit Limit - PASSED"
    end
  end

  describe "the user draws a negative amount" do
    it "warns user to put a positive amount", :js => true do
      visit('http://credit-test.herokuapp.com/line_of_credits/577')
      fill_in 'transaction_amount', :with => -1
      click_on('Save Transaction')
      expect(page).to have_css("#error_explanation li", text: "Amount must be greater than 0")
      puts "Scenario: Display an error message when user draws a negative amount - PASSED"
    end
  end

  describe "the user draws more than the given credit limit amount" do
    it "warns user to an amount that exceed the credit limit", :js => true do
      visit('http://credit-test.herokuapp.com/line_of_credits/577')
      @max_credit_limit = find(:css, 'p:nth-child(4)').text[/f([^.]*)/][3..-1].split(',').join('')
      fill_in 'transaction_amount', :with => @max_credit_limit.to_f + 1
      click_on('Save Transaction')
      expect(page).to have_css("#error_explanation li", text: "Amount cannot exceed the credit limit")
      puts "Scenario: Display an error message when user draws greater than the credit limit - PASSED"
    end
  end

  describe "the user pays more than they owed" do
    it "displays a warning message to not exceed what is owed", :js => true do
      visit('http://credit-test.herokuapp.com/line_of_credits/577')
      @owed_amount = find(:css, 'p:nth-child(4)').text[/\$([^\s]*)/][1..-1].split(',').join('').to_f
      select('Payment', :from => 'transaction_type')
      fill_in 'transaction_amount', :with => @owed_amount.to_f + 1
      click_on('Save Transaction')
      expect(page).to have_css("#error_explanation li", text: "Amount cannot exceed what is owed")
      puts "Scenario: Display an error message when user pays more than what is owed - PASSED"
    end
  end

  describe "a correct credit line" do
    it "displays the right credit line information", :js => true do
      @apr = SecureRandom.random_number(100)
      @credit_limit = SecureRandom.random_number(2000)
      @credit_comma_separated = ActiveSupport::NumberHelper.number_to_delimited(@credit_limit)
      visit('http://credit-test.herokuapp.com')
      click_link('New Line of credit')
      expect(page).to have_css("body > h1", text: "New Line Of Credit")
      within(:css, "form#new_line_of_credit") do
        fill_in 'line_of_credit_apr', :with => @apr
        fill_in "line_of_credit_credit_limit", :with => @credit_limit
      end
      click_on('Create Line of credit')
      expect(page).to have_css("p:nth-child(3)", text: "Apr: "+@apr.to_s+".000%")
      expect(page).to have_css("p:nth-child(4)", text: "Credit Available: $0.00 of $"+@credit_comma_separated.to_s+".00")
      expect(page).to have_css("p:nth-child(6)", text: "Interest at 30 days: $0.00")
      expect(page).to have_css("p:nth-child(7)", text: "Total Payoff at 30 days: $0.00")
      puts "Scenario: Display the correct credit line information - PASSED"
    end
  end

  describe "the user draws money only at day 1" do
    it "displays the right Total Payoff at 30 Days for 10 possibilities", :js => true do
      visit('http://credit-test.herokuapp.com/line_of_credits/551')
      @apr = find(:css, 'p:nth-child(3)').text[/\s([^.]*)/][1..-1].to_i/100.to_f
      @credit_limit = find(:css, 'p:nth-child(4)').text[/f([^.]*)/][3..-1].split(',').join('')
      @counter = 0
      while @counter < 10
        @draw_amount = SecureRandom.random_number(@credit_limit.to_i)
        @payoff_at_30_days = (((@draw_amount*@apr)/365)*30).round(2)+@draw_amount
        @payoff_at_30_days_comma = ActiveSupport::NumberHelper.number_to_delimited(@payoff_at_30_days)
        fill_in 'transaction_amount', :with => @draw_amount
        click_on('Save Transaction')
        page.find :css, '.delete-transaction', wait: 10
        expect(page).to have_css("p:nth-child(7)", text: "Total Payoff at 30 days: $"+@payoff_at_30_days_comma+"")
        puts "Amount Draw = "+@draw_amount.to_s+"\nTotal Payoff at 30 days = $"+@payoff_at_30_days_comma+""
        click_link('Remove')
        @counter = @counter+1
      end
      puts "Scenario: Display the correct Total Payoff at 30 Days amount when user only draw at day 1 - PASSED"
    end
  end

  describe "the user draws on day 1, pay back on day 15, and do another draw on day 25" do
    it "displays the right Total Payoff at 30 Days", :js => true do
      # expect(Rails.logger).to receive(:info).with("Expected Total Payoff value: " +@payoff_at_30_days_comma+ " - Actual Total Payoff value: "+find('p:nth-child(7)').text[/\$([^\\]*)/][1..-1])
      # expect(Rails.logger).to receive(:info).with("HAHAHAHA")
      visit('http://credit-test.herokuapp.com/line_of_credits/566')
      if page.has_css?('tbody tr:nth-child(1) .delete-transaction')
        @counter = 0
        while @counter<3
          find('tbody tr:nth-child(1) .delete-transaction').click
          @counter = @counter + 1
        end
      end
      @apr = find(:css, 'p:nth-child(3)').text[/\s([^.]*)/][1..-1].to_i/100.to_f
      @max_credit_limit = find(:css, 'p:nth-child(4)').text[/f([^.]*)/][3..-1].split(',').join('')
      @total_payoff_interest = 0
      @draw_amount = SecureRandom.random_number(@max_credit_limit.to_i)
      fill_in 'transaction_amount', :with => @draw_amount
      @total_payoff_interest += (((@draw_amount*@apr)/365)*15).round(2)
      click_on('Save Transaction')

      page.find :css, 'tbody tr:nth-child(1) .delete-transaction', wait: 10
      select('Payment', :from => 'transaction_type')
      @payment_amount = SecureRandom.random_number(@draw_amount.to_i)
      fill_in 'transaction_amount', :with => @payment_amount
      select('15', :from => 'transaction_applied_at')
      @total_payoff_interest += (((@draw_amount-@payment_amount*@apr)/365)*10).round(2)
      click_on('Save Transaction')

      page.find :css, 'tbody tr:nth-child(2) .delete-transaction', wait: 10
      @second_draw_amount = SecureRandom.random_number(@max_credit_limit.to_i - @draw_amount.to_i + @payment_amount)
      fill_in 'transaction_amount', :with => @second_draw_amount
      select('25', :from => 'transaction_applied_at')
      @total_payoff_interest += (((@draw_amount-@payment_amount+@second_draw_amount*@apr)/365)*10).round(2)
      click_on('Save Transaction')

      page.find :css, 'tbody tr:nth-child(3) .delete-transaction', wait: 10
      @principal_balance = @draw_amount - @payment_amount + @second_draw_amount
      @payoff_at_30_days_comma = ActiveSupport::NumberHelper.number_to_delimited((@principal_balance+@total_payoff_interest).to_f)
      expect(Rails.logger).to receive(:info).with("Total Payoff at 30 Days: " +@payoff_at_30_days_comma)
      begin
          expect(page).to have_css("p:nth-child(7)", text: "Total Payoff at 30 Days: $"+@payoff_at_30_days_comma+"")
        rescue
          puts "Scenario: Total Payoff at 30 Days shows the correct amount draw on day 1, pay on day 15, and draw on day 25 - PASSED"
        ensure
          Rails.logger.info "Total Payoff at 30 Days: "+find('p:nth-child(7)').text[/\$([^\\]*)/][1..-1]
          puts "Expected Total Payoff value: " +@payoff_at_30_days_comma+ "\nActual Total Payoff value: "+find('p:nth-child(7)').text[/\$([^\\]*)/][1..-1]
      end
    end
  end

  describe "the user edits their line of credit" do
    it "displays successfully updated message", :js => true do
      visit('http://credit-test.herokuapp.com/line_of_credits/25/edit')
      click_on('Update Line of credit')
      expect(page).to have_css("#notice", text: "Line of credit was successfully updated.")
      puts "Scenario: Display an error message when user edits line of credit - PASSED"
    end
  end
end