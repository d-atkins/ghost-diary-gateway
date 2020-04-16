require 'rails_helper'

RSpec.describe "Admin dashboard -" do
  describe 'Admin' do
    before(:each) do
      admin = create(:user, role: 0)
      day_1 = create(:day)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      allow_any_instance_of(ApplicationController).to receive(:day_today).and_return(day_1)

      visit admin_dashboard_path
    end

    it "can click link to see all posts" do
      click_link ('All Posts')

      expect(current_path).to eq(admin_posts_path)
    end
  end
end
