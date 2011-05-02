class AdminController < ApplicationController
  
  def show
    @admin = Shooter.find(session[:shooter_id])
    respond_to do |format|
      format.html
    end
  end
  
  def show_shooters
    @shooters = Shooter.all()
    respond_to do |format|
      format.html
    end
  end
  
  def toggle_admin
    @shooter = Shooter.find(params[:shooter])
    @shooter.is_admin = !@shooter.is_admin
    @shooter.save
    redirect_to :action => "show_shooters"
  end
  
  def delete_shooter
    @shooter = Shooter.find(params[:shooter])
    @shooter.destroy
    redirect_to :action => "show_shooters"
  end
  
end
