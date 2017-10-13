class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  # GET /cars
  # GET /cars.json
  def index
    #@cars = Car.all
    @booking = Booking.where("user_id = ? AND status < 2", current_user.id)
    @options_for_search = Car.attribute_names.select {|c| c.include?('model') || c.include?('description') || c.include?('style') || c.include?('status') || c.include?('manufacturer')}
    if @booking.length > 0 then
      @cars = []
      respond_to do |format|
        format.html { redirect_to current_user,notice: 'You already have a booking. Please finish that 1st' }
      end
    elsif !params[:search].blank? and !params[:search_by].blank?
      @cars = Car.search(params[:search], params[:search_by])
    else
      @cars = Car.all
    end
  end

  def email_notification
    @car = Car.find(params[:id])
    @user = User.find(params[:id1])
    @car.update_attribute(:user, @user.email)
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
    @car = Car.find(params[:id])
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
    @car = Car.find(params[:id])
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to current_user, notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_car
    @car = Car.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def car_params
    params.require(:car).permit(:model, :description, :license_number, :manufacturer, :style, :price, :location, :email_register)
  end

  def type(val)
    if(val==0)
      return 'Available'
    elsif(val==1)
      return 'Reserved'
    else
      return 'Checked Out'
    end
  end
  helper_method :type
end
