class LoginsController < ApplicationController
  layout 'application'
  before_filter :find_user, only: :create

  def create
    if @user && @user.password == params[:user][:password]
      session[:user] = @user.token
      redirect_to top_hotels_path
    else
      flash[:error] = t('logins.fail')
      redirect_to logins_path
    end
  end

  def destroy
    reset_session
    redirect_to top_hotels_path
  end

  private

  def find_user
    @user = User.where(email: params[:user][:email]).first
  end
end
