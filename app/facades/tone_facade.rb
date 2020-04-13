class ToneFacade

  def initialize(given_text)
    @given_text = given_text
  end

  def assign_tone
    if @given_text == ""
      tone = "empty"
    elsif @given_text != ""
      encoded_text = Addressable::URI.encode_component(@given_text)
      tone_service = ToneService.new
      tone_info = tone_service.get_tone_by_text(encoded_text)
      tone = Tone.new(tone_info).get_max_tone
    end
  end
end
