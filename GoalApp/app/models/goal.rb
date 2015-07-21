class Goal < ActiveRecord::Base
  include Commentable

  validates :user_id, :body, presence: true
  validates_inclusion_of :goal_type, in: [true, false], message: "can't be blank"

  belongs_to :user
  has_many :cheers

  def self.leaderboard
    self.joins(:cheers)
        .group("goals.id")
        .order("COUNT(cheers.id) DESC")
        .limit(10)
        .select("goals.*, COUNT(cheers.id) AS num_cheers")
  end

  # SELECT
  #   goals.*, COUNT(cheers.id)
  # FROM
  #   goals
  # LEFT OUTER JOIN
  #   cheers
  # ON
  #   cheers.goal_id = goals.id
  # GROUP BY
  #   goals.id
  # ORDER BY
  #   COUNT(cheers.id) DESC
  # LIMIT
  #   10
end
