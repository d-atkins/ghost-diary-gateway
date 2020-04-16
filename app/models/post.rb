class Post < ApplicationRecord
  validates_presence_of :body
  validates_presence_of :tone

  has_many :reactions, dependent: :destroy
  belongs_to :day
  belongs_to :user

  validates_length_of :body, maximum: 222

  def reactions_by_user(user)
    user_reactions = self.reactions.where(user: user)
    (0..4).to_a.map do |category|
      user_reactions.find_by(category: category)
    end
  end

  def add_reaction(user, category)
    reaction = Reaction.new(user: user, category: category)
    reactions << reaction unless reactions.find_by(user: reaction.user, category: reaction.category)
    destroy_opposite_reaction(user, reaction)
  end

  private

    def destroy_opposite_reaction(user, reaction)
      opposite = reactions.find_by(category: reaction.opposite, user: user)
      reactions.destroy(opposite) if opposite
    end
end
