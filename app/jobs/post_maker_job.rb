class PostMakerJob < ApplicationJob
  queue_as :default

  def perform(post_body, user_id, day_id)
    tone = ToneService.get_tone_by_text(post_body)
    post = Post.new(body: post_body, user_id: user_id, day_id: day_id, tone: tone)
    post.save
  end
end
