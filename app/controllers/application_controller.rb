class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  helper_method :current_project
  def current_project
    Project.find(session[:project_id]) rescue Project.last
  end
  def redirect_if_not_current_user
    user_id = params[:status_report][:user_id]
    if user_id && user_id != current_user.id
      sign_out(current_user)
      redirect_to new_user_session_path
      false
    else
      true
    end
  end
end
