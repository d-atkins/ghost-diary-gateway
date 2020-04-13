require "rails_helper"

RSpec.describe "as a registered user" do
  context "on its stats page" do
    it "can see the total number of posts it made" do
      user = create(:user)
      4.times { create(:post, user: user) }
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/profile/stats"

      expect(page).to have_content("Total posts: 4")
    end
  end
end
