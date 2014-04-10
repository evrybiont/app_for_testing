class SignupsController < ApplicationController
  layout 'application'

  def new
    if current_user
      flash[:error] = t('signups.already_signup')
      redirect_to top_hotels_path
    end
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.new(params[:user].merge(token: params[:authenticity_token]))
    if @user.save
      session[:user] = @user.token
      flash[:success] = t('signups.create')
      redirect_to top_hotels_path
    else
      render :new
    end
  end
end
