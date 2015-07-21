class Cheer < ActiveRecord::Base
  validates :user_id,
  uniqueness: { scope: :goal_id, message: "Can't cheer goal more than once" }

  validate :cannot_cheer_own_goal
  validate :maximum_cheer_number

  validates :user_id, :goal_id, presence: true

  belongs_to :user
  belongs_to :goal

  private

  def cannot_cheer_own_goal
    if goal.user == user
      errors[:user] << "Can't cheer your own goal"
    end
  end

  def maximum_cheer_number
    if user.cheers.length >= 10
      errors[:user] << "You are out of cheers"
    end
  end
end
