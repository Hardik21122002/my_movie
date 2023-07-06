# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   byebug
  #   redirect_to edit_password_path
  #   # byebug
  # end

  # POST /resource/sign_in
  # def create
  #   if (current_user && current_user.role == "theater_admin") 
  #     #  redirect_to theater_path(current_user.theater_ids)
  #     # redirect_to theaters_path 
  #     redirect_to root_path
  #   else
  #     redirect_to root_path
  #   end
  # end

  # DELETE /resource/sign_out
  def destroy
    # super
    sign_out current_user
    redirect_to new_user_session_path
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
