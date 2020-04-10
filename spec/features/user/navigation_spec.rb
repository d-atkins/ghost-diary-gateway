require 'rails_helper'

RSpec.describe "As a Registered User" do
  it "I can see a navbar with certain links" do
    group_1 = Group.create(name: 'Mod 1')
    user = User.create(name: 'user', uid: '1111', group: group_1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/"

    within '.topnav' do
      expect(page).to have_link('Home')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
      expect(page).to_not have_link('Log in with GitHub')
    end
  end
end
