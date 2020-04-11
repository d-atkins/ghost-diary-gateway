require 'rails_helper'

RSpec.describe "As an Admin" do
  it "I can see a navbar with certain links" do
    admin = create(:user, role: 0)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/"

    within '.topnav' do
      expect(page).to have_link('Home')
      expect(page).to have_link('Dashboard')
      expect(page).to have_link('Logout')
      expect(page).to_not have_link('Profile')
      expect(page).to_not have_link('Log in with GitHub')
    end
  end
end
