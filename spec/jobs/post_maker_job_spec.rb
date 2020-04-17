require 'rails_helper'

RSpec.describe PostMakerJob, type: :job do
  include ActiveJob::TestHelper

  before(:each) do
    create(:user)
    create(:day)
  end

  subject(:job) { described_class.perform_later('hello', 1, 1) }

  it 'queues the job' do
    expect { job }
      .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it 'is in default queue' do
    expect(PostMakerJob.new.queue_name).to eq('default')
  end

  it 'executes perform' do
    expect(ToneService).to receive(:get_tone_by_text).with('hello')
    perform_enqueued_jobs { job }
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
