module WordHelper
  def category_to_word(category)
    ['Like', 'Dislike', 'Can relate', 'Funny!', 'Ugh..'][category]
  end

  def written_number(number)
    return number if number > 10
    ['nobody', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten'][number]
  end
end
