require 'rails_helper'

RSpec.describe "As a Admin" do
  before(:each) do
    group_1 = create(:group, name: 'Mod 1')
    group_2 = create(:group, name: 'Mod 2')
    user = create(:user, group: group_1)
    admin = create(:user, role: 0)
    day_1 = create(:day, week: 1, day_of_week: 1, group: group_1)
    day_2 = create(:day, week: 1, day_of_week: 1, group: group_2)
    day_3 = create(:day, week: 1, day_of_week: 2, group: group_1)
    @post_1 = create(:post, day: day_1, user: user)
    @post_2 = create(:post, day: day_1, user: user)
    @post_3 = create(:post, day: day_1, user: user)
    @post_4 = create(:post, day: day_2)
    @post_5 = create(:post, day: day_3, user: user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    allow_any_instance_of(ApplicationController).to receive(:day_today).and_return(day_1)
  end

  it "can see all posts from my dashboard" do
    admin = create(:user, role: 0)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    expect(page).to have_content(@post_1.body)
    expect(page).to have_content(@post_2.body)
    expect(page).to have_content(@post_3.body)
    expect(page).to have_content(@post_4.body)
    expect(page).to have_content(@post_5.body)
  end

  it "I can delete posts" do
    admin = create(:user, role: 0)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    within ".post-#{@post_1.id}" do
      click_on "Delete Post"
    end

    expect(current_path).to eq("/admin/dashboard")

    expect(page).to_not have_content(@post_1.body)
  end
end
