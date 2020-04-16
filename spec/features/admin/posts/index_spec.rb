require 'rails_helper'

RSpec.describe "Admin posts index -" do
  describe 'Admin' do
    before(:each) do
      admin = create(:user, role: 0)
      day_1 = create(:day)
      @post_1 = create(:post)
      @post_2 = create(:post)
      @post_3 = create(:post)
      @post_4 = create(:post)
      @post_5 = create(:post)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      allow_any_instance_of(ApplicationController).to receive(:day_today).and_return(day_1)
      visit admin_posts_path
    end

    it "can see all posts from my dashboard" do
      expect(page).to have_content(@post_1.body)
      expect(page).to have_content(@post_2.body)
      expect(page).to have_content(@post_3.body)
      expect(page).to have_content(@post_4.body)
      expect(page).to have_content(@post_5.body)
    end
  end
end
