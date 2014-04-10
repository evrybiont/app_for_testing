class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.where(token: session[:user]).first
  end
  helper_method :current_user

  private

  def find_hotel
    @hotel = Hotel.where(id: params[:id]).first
    (render 'public/record_not_found', layout: false) unless @hotel
  end

  def required_login_user
    unless current_user
      flash[:error] = t('errors.required_user')
      redirect_to :back
    end
  end

  def required_owner_hotel
    unless @hotel.user == current_user
      flash[:error] = t('errors.required_owner')
      redirect_to hotel_path @hotel
    end
  end
end
