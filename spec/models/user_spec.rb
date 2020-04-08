require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:uid) }
    it { should validate_uniqueness_of(:uid) }
    it { should define_enum_for(:role).with_values([:admin, :registered_user]) }
  end

  describe 'relationships' do
    it { should have_many(:posts) }
    it { should belong_to(:group) }
  end
end
