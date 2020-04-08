require 'rails_helper'

RSpec.describe Day, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:week) }
    it { should validate_presence_of(:day_of_week) }
    it { should define_enum_for(:day_of_week) }
  end

  describe 'relationships' do
    it { should belong_to(:group) }
    # it { should have_many(:day_posts) }
    # it { should have_many(:posts).through(:day_posts) }
  end
end
