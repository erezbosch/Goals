class GoalsController < ApplicationController
  before_action :redirect_unless_logged_in
  before_action :redirect_unless_current_user, only: [:edit, :destroy]
  before_action :redirect_if_private_goal, only: :show

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to user_url(@goal.user_id)
  end

  def leaderboard
    @goals = Goal.leaderboard
  end

  private

  def goal_params
    params.require(:goal).permit(:body, :goal_type)
  end

  def redirect_unless_current_user
    redirect_to root_url unless Goal.find(params[:id]).user == current_user
  end

  def redirect_if_private_goal
    redirect_to root_url if !Goal.find(params[:id]).goal_type &&
                            current_user != Goal.find(params[:id]).user
  end
end
