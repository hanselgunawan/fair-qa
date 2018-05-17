require 'rails_helper'
RSpec.describe "Home", type: :request do
  describe "Visit the damn home" do
    it "home is visited", :js => true do
      visit('http://credit-test.herokuapp.com')
      click_link('New Line of credit')
    end
  end
end