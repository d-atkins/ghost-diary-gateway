module IconHelper
  def reaction_icon(number)
    ['thumb_up', 'thumb_down', 'favorite', 'sentiment_very_satisfied', 'sentiment_neutral'][number]
  end
end
