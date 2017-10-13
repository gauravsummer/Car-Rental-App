class BookingsController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :set_car
  before_action :set_user
  before_action :set_users
  before_action :set_booking, only: [:show, :edit, :update, :destroy]


  # GET /bookings
  # GET /bookings.json
  def index
    #puts current_user.id
    if(current_user.user_type == 2)
      @bookings = Booking.where("user_id = ?", current_user.id)
    else
      if(@user == nil and @car == nil)
        @bookings = Booking.all
      elsif(@car == nil)
        @bookings = Booking.where("user_id = ?", @user.id)
      else
        @bookings = Booking.where("car_id = ?", @car.id)
      end

      #@bookings = Booking.all
    end
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
    @users= User.where(user_type: 2).all
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)
    @booking.car_id = @car.id
    if current_user.user_type == 2
      @booking.user_id = current_user.id
    end
    @booking.status = 0
    respond_to do |format|
      if @booking.save then
        @car.status = 'Reserved'
        @car.save
        if current_user.user_type == 2
          format.html { redirect_to current_user, notice: 'Booking was successfully created' }
        else
          format.html { redirect_to cars_path(), notice: 'Booking was successfully created' }
        end

        format.json { render action: 'show', status: :created, location: @booking }
      else
        flash[:notice] = @msg
        format.html { render action: 'new' }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to current_user, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @car = Car.find(@booking.car_id)
    @booking.destroy
    @car.status = 'Available'
    @car.save
    if @car.email_register and !@car.user.empty?
      user = User.find_by_email(@car.user)
      ApplicationMailer.car_available_email_notification(user).deliver_now
      @car.user = nil
      @car.email_register = false
      @car.save!
    end
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def check_out
    @booking = Booking.find(params[:id])
    @booking.status = 1
    respond_to do |format|
      if @booking.save then
        @car = Car.find(@booking.car_id)
        @car.status = 'Checked Out'
        @car.save
        format.html { redirect_to bookings_url, notice: 'Car checked out successfully' }
      else
        format.html { redirect_to bookings_url, notice: 'Something went wrong, please try again' }
      end
    end
  end

  def return
    @booking = Booking.find(params[:id])
    @car = Car.find(@booking.car_id)
    @booking.status = 2
    if @car.email_register and !@car.user.empty?
      user = User.find_by_email(@car.user)
      ApplicationMailer.car_available_email_notification(user).deliver_now
      @car.user = nil
      @car.email_register = false
      @car.save!
    end
    respond_to do |format|
      if @booking.save then
        @car = Car.find(@booking.car_id)
        @car.status = 'Available'
        @car.save



        format.html { redirect_to bookings_url, notice: 'Car Returned successfully' }
      else
        format.html { redirect_to bookings_url, notice: 'Something went wrong, please try again' }
      end
    end
  end


  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def set_car
    if(params[:car_id] != nil)
      @car = Car.find(params[:car_id])
    end
  end

  def set_user
    if(params[:user_id] != nil)
      @user = User.find(params[:user_id])
    end
  end

  def set_booking
    #puts params[:id]
    @booking = Booking.find(params[:id])
  end

  def type(val)
    if(val == 0)
      return 'Reserved'
    elsif(val == 1)
      return 'Checked Out'
    else
      return 'Returned'
    end
  end
  helper_method :type

  private
  def booking_params
    params.require(:booking).permit(:start_time, :end_time, :user_id)
  end
  def set_users
    @users= User.where(user_type: 2).all
  end
end
