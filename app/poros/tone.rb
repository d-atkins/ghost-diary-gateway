class Tone
  attr_reader :get_max_tone

  def initialize(tone_info)
    @tone_info = tone_info
  end

  def get_max_tone
    @tone_info[:document_tone][:tones].max_by {|hash| hash[:score]}[:tone_name]
  end
end
