require "rails_helper"

RSpec.describe "as a registered user" do
  context "on the posts page" do
    it "can create a new post" do
      group_1 = Group.create(name: 'Mod 1')
      user = User.create(name: 'user', uid: '1111', group: group_1)
      day = Day.create(week: 1, day_of_week: 1, group: group_1)
      tone = "not blank"
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      expect { post "/profile/posts", params: { body: "Like Ice Cube said: 'today was a good day'", tone: tone, day_id: day.id } }.to change(Post, :count).by(1)
    end
  end
end
