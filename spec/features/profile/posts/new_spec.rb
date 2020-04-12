require "rails_helper"

RSpec.describe "as a registered user" do
  context "on the posts page" do
    it "can create a new post" do
      group_1 = Group.create(name: 'Mod 1')
      user = User.create(name: 'user', uid: '1111', group: group_1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit "/posts"
      expect(page).to_not have_content("Like Ice Cube said: 'today was a good day'")
      fill_in "body", with: "Like Ice Cube said: 'today was a good day'"
      click_on "Submit"
      visit "/profile/posts"
      expect(page).to have_content("Like Ice Cube said: 'today was a good day'")
    end
  end
end
