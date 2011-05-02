class SessionsController < ApplicationController
  skip_before_filter :authorize
  def new
    @login = ""
  end

  def create 
    if shooter = Shooter.authenticate(params[:name] ,params[:email], params[:password])
      session[:shooter_id] = shooter.id
      puts "got shooter"
      redirect_to :controller => "shooter", :action => "show", :id => shooter.id
    else
      redirect_to "/sessions/new", :alert => "Invalid user/password combination"
    end 
  end
  
  def destroy
    session[:user_id] = nil 
    redirect_to :action => "new", :notice => "Logged out"
  end

end
