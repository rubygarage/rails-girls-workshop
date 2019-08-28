class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]

  def index
    @goals = chosen_filter
    @goals.order('complete, due_date, priority DESC, title')
  end

  def show; end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    if @goal.save
      flash[:success] = 'Your goal has been successfully created'
      redirect_to goals_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @goal.update_attributes(goal_params)
      flash[:success] = 'Your goal has been successfully updated'
      if @goal.complete?
        redirect_to goals_path(filter: 'completed')
      else
        redirect_to goals_path
      end
    else
      render 'edit'
    end
  end

  def destroy
    @goal.destroy
    flash[:info] = 'Your goal has been successfully deleted'
    redirect_to goals_path
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :description, :priority, :due_date, :complete)
  end

  def set_goal
    @goal = Goal.find_by(id: params[:id])
  end

  def chosen_filter
    if params[:filter] == 'completed'
      Goal.completed
    elsif params[:filter] == 'incomplete'
      Goal.incomplete
    else
      Goal.all
    end
  end
end
