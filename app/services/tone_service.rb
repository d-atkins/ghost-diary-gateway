class ToneService

  def get_tone_by_text(text)
    response = conn.get("/api/v1/tone") do |request|
      request.params["body"] = text
      request.params["apikey"] = ENV["ANALYZER_API_KEY"]
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new(ENV["TONE_SERVICE_DOMAIN"])
  end

end
