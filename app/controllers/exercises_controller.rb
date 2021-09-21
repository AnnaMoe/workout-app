class ExercisesController < ApplicationController
  before_action :set_exercise, only: [:destroy, :show, :edit, :update  ]

  def index
    @exercises = current_user.exercises
    @friends = current_user.friends
    set_current_room
    @message = Message.new
    @messages = current_room.messages if current_room
    @followers = Friendship.where(friend_id: current_user.id)
  end

  def show
  end

  def new
    @exercise = current_user.exercises.new
  end

  def create
    @exercise = current_user.exercises.new(exercise_params)
    if @exercise.save
      flash[:notice] = "Exercise has been created"
      # redirect_to user_exercise_path(current_user, @exercise) 
      # can be written shorter:
      redirect_to [current_user, @exercise]
    else
      flash[:alert] = "Exercise has not been created"
      render "new"
    end
  end

  def edit
  end

  def update
    if @exercise.update(exercise_params)
      flash[:notice] = "Exercise has been updated"
      # redirect_to user_exercise_path(current_user, @exercise) 
      # can be written shorter:
      redirect_to [current_user, @exercise]
    else
      flash[:alert] = "Exercise has not been updated"
      render "edit"
    end
  end

  def destroy
    
    if @exercise.destroy
      flash[:notice] = "Exercise has been deleted"
      redirect_to user_exercises_path(current_user)
    end
  end

  private

  def set_exercise
    @exercise = current_user.exercises.find params[:id]
  end

  def exercise_params
    params.require(:exercise).permit(:duration_in_min, :workout, :workout_date, )
  end

  def set_current_room
    #if we pass a roomid from the form to this controller
    if params[:roomId]
      @room = Room.find_by(id: params[:roomId])
    else
      @room = current_user.room
    end
    session[:current_room] = @room.id if @room
  end

end