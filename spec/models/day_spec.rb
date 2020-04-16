require 'rails_helper'

RSpec.describe Day, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:week) }
    it { should validate_presence_of(:day_of_week) }
    it { should define_enum_for(:day_of_week).with_values([:Sunday, :Monday, :Tuesday, :Wednesday, :Thursday, :Friday, :Saturday]) }
  end

  describe 'relationships' do
    it { should belong_to(:group) }
    it { should have_many(:posts) }
  end

  describe 'methods' do
    it 'display_week' do
      week_1 = create(:day, week: 1)
      week_2 = create(:day, week: 2)
      intermission = create(:day, week: 0)
      vacation = create(:day, week: -1)

      expect(week_1.display_week).to eq('Week 1')
      expect(week_2.display_week).to eq('Week 2')
      expect(intermission.display_week).to eq('Intermission Week')
      expect(vacation.display_week).to eq('Vacation Week')
    end
  end
end
