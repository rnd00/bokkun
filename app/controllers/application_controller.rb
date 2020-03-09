class ApplicationController < ActionController::Base
  before_action :configure_permitted_params, only: [:create]
  before_action :authenticate_user!
  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  # Redirect user to dashboard after login
  def after_sign_in_path_for(resource)
    if resource.manager
      employer_dashboard_path
    else
      employee_dashboard_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  private

  def configure_permitted_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :email,
      :password,
      :password_confirmation,
      :first_name,
      :last_name,
      :job_title
    ])
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
