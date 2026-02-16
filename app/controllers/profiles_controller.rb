# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  before_action :set_user
  before_action :set_profile, only: [ :show, :edit, :update, :destroy ]

  # GET /users/:user_id/profile
  def show
  end

  # GET /users/:user_id/profile/new
  def new
    @profile = @user.build_profile
  end

  # POST /users/:user_id/profile
  def create
    @profile = @user.build_profile(profile_params)
    if @profile.save
      redirect_to user_path(@user), notice: "Profile created successfully."
    else
      render :new
    end
  end

  # GET /users/:user_id/profile/edit
  def edit
  end

  # PATCH/PUT /users/:user_id/profile
  def update
    if @profile.update(profile_params)
      redirect_to user_path(@user), notice: "Profile updated successfully."
    else
      render :edit
    end
  end

# DELETE /users/:user_id/profile
def destroy
  @profile.destroy
  redirect_to user_path(@user), notice: "Profile deleted successfully."
end


  private

  # Always set the user
  def set_user
    @user = User.find(params[:user_id])
  end

  # Set profile (for singular nested resource)
  def set_profile
    @profile = @user.profile
  end

  # Strong parameters
  def profile_params
    params.require(:profile).permit(:phone, :bio) # remove :address if it doesn't exist in your table
  end
end
