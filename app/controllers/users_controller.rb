class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  def show_admin
    @users = User.all
  end

  def show_superadmin
    @users = User.all
  end
  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        log_in @user
        flash[:success] = "Welcome to the Car Rental App!"
        format.html { redirect_to @user}
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def newuser
    @user = User.new
  end

  def newadmin
    @user = User.new
  end

  def newsuperadmin
    @user = User.new
  end

  def createuser
    @user = User.new(user_params)

    if @user.save
      redirect_to current_user, notice: 'User was successfully created.'
    else
      render :new,  notice: 'User was not created!'
    end
  end

  def createadmin
    @user = User.new(user_params)
    @user.user_type = 1
    if @user.save
      redirect_to current_user, notice: 'Admin was successfully created.'
    else
      render :new, notice: 'Admin was not created!'
    end
  end

  def createsuperadmin
    @user = User.new(user_params)
    @user.user_type = 0
    if @user.save
      redirect_to current_user, notice: 'Super Admin was successfully created.'
    else
      render :new, notice: 'Super Admin was not created!'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = "Profile updated"
        format.html { redirect_to current_user}
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if(@user.user_type > 0)
      if(@user.user_type == 2)
        @booking = Booking.where("user_id = ? AND status < 2", @user.id)
        if @booking.length > 0
          respond_to do |format|
            format.html { redirect_to users_path, notice: 'User has an active booking. Can not be deleted.' }
            #format.json { head :no_content }
          end
        else
          @user.destroy
          respond_to do |format|
            format.html { redirect_to users_path, notice: 'User was successfully deleted.' }
            format.json { head :no_content }
          end
        end
      else
        @user.destroy
        respond_to do |format|
          format.html { redirect_to show_admin_path, notice: 'Admin was successfully deleted.' }
          format.json { head :no_content }
        end
      end
    else
      format.html { redirect_to :back, notice: 'Super Admin cannot be deleted.' }
    end
  end


    # Use callbacks to share common setup or constraints between actions.
  def set_user
    if(params[:id] == nil)
      @user = current_user
    else
      @user = User.find(params[:id])
    end
  end

    # Never trust parameters from the scary internet, only allow the white list through.

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def type(val)
    if(val == 0)
      return 'Super Admin'
    elsif(val == 1)
      return 'Admin'
    else
      return 'User'
    end
  end
  helper_method :type

end
