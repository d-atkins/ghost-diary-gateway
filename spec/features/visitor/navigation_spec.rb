require 'rails_helper'

RSpec.describe "As a Visitor" do
  it "I see a navbar with a link to sign in with GitHub" do
    visit "/"

    within '.topnav' do
      expect(page).to have_link('Log in with GitHub')
      expect(page).to_not have_link('Home')
      expect(page).to_not have_link('Profile')
      expect(page).to_not have_link('Logout')
    end
  end
end
