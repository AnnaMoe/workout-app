class ExercisesController < ApplicationController
  def index

  end

  def new
  #  @exercise = current_user.exercises.new
   @exercise = Exercise.new
  end

  def create

  end

end
