require "rails_helper"

describe 'Sessions -' do
  describe 'Logged in user' do
    it 'can log out' do
      group_1 = Group.create(name: 'Mod 1')
      user = create(:user, role: 1, group: group_1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit '/'
      expect(page).to_not have_content("Log in with GitHub")
      find("a[href='#{logout_path}']").click
      expect(current_path).to eq('/')
      expect(page).to have_content("You have logged out")
    end
  end
end
