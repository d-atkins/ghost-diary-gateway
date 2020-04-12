class ToneService

  def get_tone_by_text(text)
    response = conn.get("/v3/tone?version=2017-09-21&text=#{text}&sentences=false")
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new('https://api.us-south.tone-analyzer.watson.cloud.ibm.com/instances/95e82454-27aa-4915-a1e6-e206440f077f') do |f|
      f.use Faraday::Request::BasicAuthentication, 'apikey', ENV["ANALYZER_API_KEY"]
    end
  end

end
