class Profile::PostsController < Profile::BaseController

  def index
    @posts = current_user.posts
  end

  def show
    @post = current_user.posts.find(params[:id])
  end

  def create
    day = Day.find_or_create_by(week: 1, day_of_week: 1, group: current_user.group)
    length = post_params[:body].length
    defaults = {day: day, tone: assign_tone(length)}
    params = defaults.merge(post_params)
    post = current_user.posts.new(params)
    post.save
    flash[:failure] = "Your post cannot exceed 222 characters. Your post was #{length} characters" if length > 222
    redirect_to posts_path
  end

  private
    def post_params
      params.permit(:body, :tone, :day)
    end

    def assign_tone(length)
      if length > 222
        tone = ""
      else
        tone = "empty" if post_params[:body] == ""
        text = Addressable::URI.encode_component(post_params[:body])
        tone = get_tone(text)[:document_tone][:tones].first[:tone_name] if post_params[:body] != ""
      end
      #set this to max_by iteration for tones
    end

    def tone_conn
      Faraday.new('https://api.us-south.tone-analyzer.watson.cloud.ibm.com/instances/95e82454-27aa-4915-a1e6-e206440f077f') do |f|
        f.use Faraday::Request::BasicAuthentication, 'apikey', ENV["ANALYZER_API_KEY"]
      end
    end

    def tone_response(text)
      tone_conn.get("/v3/tone?version=2017-09-21&text=#{text}&sentences=false")
    end

    def get_tone(text)
      JSON.parse(tone_response(text).body, symbolize_names: true)
    end

    #refactor using service, and maybe a poro (pass in hash to poro, and do iteration in there)

end
