class CommentsController < ApplicationController
  before_filter :required_login_user
  before_filter :find_hotel

  def create
    @hotel.comments.create(params[:comment].merge(user_id: current_user.id))
    redirect_to @hotel
  end
end
