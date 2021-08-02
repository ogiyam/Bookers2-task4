class RelationshipsController < ApplicationController

  before_action :authenticate_user!,except: [:top]
  before_action :correct_user,   only: [:followers]

   def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
   end

   def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
   end

   def followings
    user = User.find(params[:user_id])
    @users = user.followings
   end

   def followers
    user = User.find(params[:user_id])
    @users = user.followers
   end
end

private

  def correct_user
   @user = User.find(params[:user_id])
   if @user.id != current_user.id
     redirect_to user_path(current_user)
   end
  end


