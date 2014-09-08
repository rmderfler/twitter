class FollowingsController < ApplicationController
  def create
  @following = current_user.followings.build(:followed_id => params[:followed_id])
  if @following.save
    flash[:notice] = "Added follow."
    redirect_to root_url
  else
    flash[:error] = "Unable to follow."
    redirect_to root_url
  end
end

def destroy
  @following = current_user.followings.find(params[:id])
  @following.destroy
  flash[:notice] = "Removed following."
  redirect_to current_user
end
end
