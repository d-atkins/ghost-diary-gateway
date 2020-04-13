class Tone
  attr_reader :get_max_tone

  def initialize(tone_info)
    @tone_info = tone_info
  end

  def get_max_tone
    tones = @tone_info[:document_tone][:tones]
    if tones.empty?
      return 'Default'
    else
      tones.max_by {|hash| hash[:score]}[:tone_name]
    end
  end
end
