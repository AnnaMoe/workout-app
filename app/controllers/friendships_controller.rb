class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    # when clicking on following button, we pass the friend_id
    friend = User.find(params[:friend_id])
    # also user_id comed from the form "following"
    params[:user_id] = current_user.id
    
    Friendship.create(friendship_params) unless current_user.follows_or_same?(friend)
    redirect_to root_path
  end

  def show
    #only want friend object and not user object: (.friend)
    @friend = Friendship.find(params[:id]).friend
    @exercises = @friend.exercises
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    friendname = @friendship.friend.full_name
    if @friendship.destroy
      flash[:notice] = "#{friendname} unfollowed."
    else
      flash.now[:alert] = "#{friendname} could not be unfollowed."
    end
    redirect_to user_exercises_path(current_user)
  end
  
  private
  
  def friendship_params
    # no form for creating friendship. So we do not use: params.require(:friendship).permit(:friend_id, :user_id)
    params.permit(:friend_id, :user_id)
  end
end
