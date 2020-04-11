require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'relationships' do
    it { should have_many(:users) }
    it { should have_many(:days) }
    it { should have_many(:posts).through(:days) }
  end
end
