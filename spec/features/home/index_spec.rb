require 'rails_helper'

RSpec.describe "Home Index Page" do
  describe "As a Visitor" do
    it "can see the Welcome Page" do
      visit '/'

      expect(page).to have_content("Welcome!")
    end

    describe 'can connect with Github' do
      before(:each) do
        OmniAuth.config.mock_auth[:github] = nil
        OmniAuth.config.test_mode = true
        OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
          {"provider"=>"github",
          "info"=> {"name"=>"Jennifer Klich"},
          "credentials"=>
          {"token"=>ENV["TEST_KEY"],
          "expires"=>false},
        "extra"=>
          {"raw_info"=>
            {"login"=>"jenny-klich",
              "html_url"=>"https://github.com/jenny-klich",
              "name"=>"Jennifer Klich",
              }}})
      end
    end
  end
end
