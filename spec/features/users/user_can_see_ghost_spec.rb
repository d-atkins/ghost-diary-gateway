require 'rails_helper'

RSpec.describe "As a Registered User" do
  it "I can see a ghost on the homepage" do
    group_1 = Group.create(name: 'Mod 1')
    user = create(:user, role: 1, group: group_1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/"

    expect(page).to have_css(".ghost-container")
  end

  it "I can see a ghost on the posts index page" do
    group_1 = Group.create(name: 'Mod 1')
    user = create(:user, role: 1, group: group_1)
    day_1 = Day.create(week: 1, day_of_week: 1, group: group_1)
    post = Post.create(body: "Wow, first day of the mod 1... syllabus day... but still so lost @.@", tone: "confuse", day: day_1, user: user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/posts"

    within ".post-#{post.id}" do
      expect(page).to have_css(".ghost-container")
    end
  end

  it "I can see a ghost on the posts show page" do
    group_1 = Group.create(name: 'Mod 1')
    user = create(:user, role: 1, group: group_1)
    day_1 = Day.create(week: 1, day_of_week: 1, group: group_1)
    post_1 = Post.create(body: "Wow, first day of the mod 1... syllabus day... but still so lost @.@", tone: "confuse", day: day_1, user: user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/posts/#{post_1.id}"

    expect(page).to have_css(".ghost-container")
  end

  it "I can see a ghost on my posts show page" do
    group_1 = Group.create(name: 'Mod 1')
    user = create(:user, role: 1, group: group_1)
    day_1 = Day.create(week: 1, day_of_week: 1, group: group_1)
    post_1 = Post.create(body: "Wow, first day of the mod 1... syllabus day... but still so lost @.@", tone: "confuse", day: day_1, user: user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/profile/posts/#{post_1.id}"

    expect(page).to have_css(".ghost-container")
  end

  it "I can see a ghost on my posts index page" do
    group_1 = Group.create(name: 'Mod 1')
    user = create(:user, role: 1, group: group_1)
    day_1 = Day.create(week: 1, day_of_week: 1, group: group_1)
    post = Post.create(body: "Wow, first day of the mod 1... syllabus day... but still so lost @.@", tone: "confuse", day: day_1, user: user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/profile/posts"

    within ".post-#{post.id}" do
      expect(page).to have_css(".ghost-container")
    end
  end
end
