require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:password)}
    it {should validate_presence_of(:role)}
  end

  describe 'relationships' do
    # it {should have_many(:posts)}
    it {should belong_to(:group)}
  end
end
