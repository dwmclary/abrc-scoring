class ApplicationController < ActionController::Base
  before_filter :authorize
  protect_from_forgery
  
  protected

  def authorize 
      unless Shooter.find_by_id(session[:shooter_id])
        redirect_to "/sessions/new", :notice => "Please log in"
      end 
  end
end
