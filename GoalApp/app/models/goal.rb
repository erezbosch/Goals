class Goal < ActiveRecord::Base
  validates :user_id, :body, presence: true
  validates_inclusion_of :goal_type, in: [true, false], message: "can't be blank"

  belongs_to :user

end
