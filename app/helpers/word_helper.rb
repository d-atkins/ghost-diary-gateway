module TestHelper
  def test_me
    'Can you see me?'
  end

  def category_to_word(category)
    ['Like', 'Dislike', 'Can relate', 'Lol', 'Upset'][category]
  end

  def written_number(number)
    return number if number > 10
    ['no one',
      'one',
      'two',
      'three',
      'four',
      'five',
      'six',
      'seven',
      'eight',
      'nine',
      'ten'][number]
  end
end
