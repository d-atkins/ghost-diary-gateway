require 'rails_helper'

RSpec.describe "Admin posts index -" do
  describe 'Admin' do
    before(:each) do
      admin = create(:user, role: 0)
      day_1 = create(:day)
      @post_1 = create(:post, body: "this is a unique post")
      create_list(:post, 4)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      allow_any_instance_of(ApplicationController).to receive(:day_today).and_return(day_1)
      visit admin_posts_path
    end

    it "I can delete posts" do
      within(".ghost-post-#{@post_1.id}") { find('#delete').click }

      expect(current_path).to eq(admin_posts_path)
      expect(page).to_not have_content(@post_1.body)
    end
  end
end
