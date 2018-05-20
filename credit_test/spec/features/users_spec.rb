require 'rails_helper'

RSpec.describe 'Home feature', js:true do
  it 'displays app name' do
    visit 'https://www.google.com'
    # expect(page).to have_content('Google')
  end
end
