class HotelsController < ApplicationController
  COUNT = 5

  before_filter :new_hotel,  only: [:new, :create]
  before_filter :find_hotel, only: [:show, :edit, :update, :destroy]
  before_filter :required_login_user,  only: [:new, :edit, :destroy]
  before_filter :required_owner_hotel, only: [:edit, :update, :destroy]

  def find
    render json: Hotel.only(:title).all
  end

  def index
    @hotels = Hotel.desc(:created_at)
    render :hotels
  end

  def top
    @hotels = Hotel.top(COUNT)
    render :hotels
  end

  def new
    @hotel.build_address
    render :form, locals: { url: hotels_path, method: 'post' }
  end

  def create
    @hotel.user = current_user
    if @hotel.save
      flash[:success] = t('hotels.create')
      redirect_to @hotel
    else
      render :form, locals: { url: hotels_path, method: 'post' }
    end
  end

  def edit
    render :form, locals: { url: hotel_path, method: 'put' }
  end

  def update
    if @hotel.update_attributes(params[:hotel])
      flash[:success] = t('hotels.update')
      redirect_to @hotel
    else
      render :form, locals: { url: hotel_path, method: 'put' }
    end
  end

  def destroy
    @hotel.remove
    flash[:success] = t('hotels.destroy')
    redirect_to hotels_path
  end

  private

  def new_hotel
    @hotel = Hotel.new(params[:hotel])
  end
end
