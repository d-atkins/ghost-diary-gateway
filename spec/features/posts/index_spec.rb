require 'rails_helper'

RSpec.describe 'Posts index -', type: :feature do
  describe 'Registered user in a group' do
    before(:each) do
      group_1 = create(:group, name: 'Mod 1')
      group_2 = create(:group, name: 'Mod 2')
      user = create(:user, group: group_1)
      day_1 = create(:day, week: 1, day_of_week: 1, group: group_1)
      day_2 = create(:day, week: 1, day_of_week: 1, group: group_2)
      day_3 = create(:day, week: 1, day_of_week: 2, group: group_1)
      create(:post, day: day_1, user: user)
      create(:post, day: day_1, user: user)
      create(:post, day: day_1, user: user)
      create(:post, day: day_2)
      create(:post, day: day_3, user: user)

      body = File.read('spec/fixtures/events.json')
      response = double("response", status: 200, body: body)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow_any_instance_of(Time).to receive(:wday).and_return(1)
      allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(response)

      visit posts_path
    end

    it 'sees a single posts belonging to that group' do
      expect(page).to have_css(".bubble")
    end

    it "can click a link to see a post's show page" do
      find('.bubble').click

      expect(current_path).to eq(posts_path)

      expect(page).to have_css(".bubble")
    end
  end
end
