require 'rails_helper'

RSpec.describe "Navbar -" do
  it "Admin" do
    admin = create(:user, role: 0)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/"

    within '.topnav' do
      expect(page).to have_css('#home')
      expect(page).to have_css('#dashboard')
      expect(page).to have_css('#logout')
      expect(page).to_not have_css('#profile')
      expect(page).to_not have_css('#login')
    end
  end

  it "Registered user" do
    group_1 = Group.create(name: 'Mod 1')
    user = User.create(name: 'user', uid: '1111', group: group_1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/"

    within '.topnav' do
      expect(page).to have_css('#home')
      expect(page).to have_css('#profile')
      expect(page).to have_css('#logout')
      expect(page).to_not have_css('#login')
    end
  end

  it "Visitor" do
    visit "/"

    within '.topnav' do
      expect(page).to have_css('#login')
      expect(page).to_not have_css('#home')
      expect(page).to_not have_css('#profile')
      expect(page).to_not have_css('#logout')
    end
  end
end
