require 'rails_helper'

RSpec.describe 'Posts create -', type: :feature do
  describe 'Registered user in a group' do
    before(:each) do
      group_1 = create(:group, name: 'Mod 1')
      user = create(:user, group: group_1)
      @day_1 = create(:day, week: 1, day_of_week: 1, group: group_1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow_any_instance_of(ApplicationController).to receive(:day_today).and_return(@day_1)
      response = double("response", status: 200, body: "\"Default\"")

      allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(response)

      visit posts_path
    end

    it 'can create a post' do
      expect(page).to_not have_css(".bubble")

      fill_in :body, with: "This is my first post. What do you think?"
      click_on('Submit')

      expect(current_path).to eq(posts_path)

      expect(page).to_not have_content("Body is too long (maximum is 222 characters)")
      expect(page).to_not have_content("Body can't be blank")
    end

    it 'can not create a post longer than 222 characters' do
      expect(page).to_not have_css(".bubble")

      text = "He’s more myself than I am. Whatever our souls are made of, his and mine are the same…my great thought in living is himself. If all else perished, and he remained, I should still continue to be; and if all else remained, and he were annihilated, the universe would turn to a mighty stranger. I should not seem a part of it."

      fill_in :body, with: text
      click_on('Submit')

      expect(page).to_not have_css(".bubble")
      expect(page).to have_content("Body is too long (maximum is 222 characters)")
    end

    it 'can not create an empty post' do
      expect(page).to_not have_css(".bubble")

      fill_in :body, with: ''
      click_on('Submit')

      expect(page).to_not have_css(".bubble")
      expect(page).to have_content("Body can't be blank")
    end

  end
end
