require 'rails_helper'

RSpec.describe "As a Visitor" do
  it "I see a navbar with a link to sign in with GitHub" do
    visit "/"

    within '.topnav' do
      expect(page).to have_content('Log in with GitHub')
    end
  end
end
