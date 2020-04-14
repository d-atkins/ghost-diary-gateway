require "rails_helper"

describe "as a logged in user" do
  it "can log out" do
    group_1 = Group.create(name: 'Mod 1')
    user = create(:user, role: 1, group: group_1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/'
    within '.topnav' do
      expect(page).to_not have_content("Log in with GitHub")
      click_on "Logout"
    end
    expect(current_path).to eq('/')
    expect(page).to_not have_content("Log in with GitHub")
  end
end
