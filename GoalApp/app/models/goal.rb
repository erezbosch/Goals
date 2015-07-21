class Goal < ActiveRecord::Base
  include Commentable

  validates :user_id, :body, presence: true
  validates_inclusion_of :goal_type, in: [true, false], message: "can't be blank"

  belongs_to :user
  has_many :cheers

end
