require 'rails_helper'

RSpec.describe Week, type: :model do
  describe 'methods' do
    describe 'determine' do
      it 'week number' do
        event_data = [
          {summary: 'not this week'},
          {summary: 'Week 4 With Jeff'},
          {summary: '9 Week'},
          {summary: 'Week 17'}]

          expect(Week.determine(event_data)).to eq(17)
      end

      it '0 for intermission week' do
        event_data = [
          {summary: 'it only gets harder'},
          {summary: 'Intermission Week'},
          {summary: 'better do that prework'},
          {summary: 'go home already'}]

          expect(Week.determine(event_data)).to eq(0)
      end

      it '-1 vacation week' do
        event_data = [
          {summary: 'Turing Social Thing'},
          {summary: 'Week of not doing stuff'},
          {summary: 'Winter Break'},
          {summary: 'This is an event'}]

          expect(Week.determine(event_data)).to eq(-1)
      end
    end
  end
end
