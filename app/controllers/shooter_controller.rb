class ShooterController < ApplicationController
  skip_before_filter :authorize, :only => [:new, :create]
  def create
    @shooter = Shooter.new(params[:shooter])
    @old_rounds = []
    respond_to do |format|
      if @shooter.save
        format.html {render :action => "show", :id => @shooter.id}
      else
        format.html {render :action => "new"}
      end
    end
  end
  
  def new
    @shooter = Shooter.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @shooter }
    end
  end
  
  def show
    @shooter = Shooter.find(session[:shooter_id])
    @old_rounds = @shooter.rounds.map{|r| {"id"=>r.id,"date"=>r.shot_at}}

    respond_to do |format|
      format.html 
      format.json {render :json => @shooter}
    end
  end
  
  def results
    @shooter = Shooter.find(params[:id])
    @rounds = @shooter.rounds
    @round_scores = @rounds.map{|r| r.total_score}
    respond_to do |format|
      format.html 
      format.json {render :json => @shooter}
    end
  end

  
  def breakdown
    @shooter = Shooter.find(params[:id])
    @rounds = @shooter.rounds
    @round_scores = @rounds.map{|r| r.total_score}
    @shots = @rounds.map{|r| r.shots}.flatten
    respond_to do |format|
      format.html 
      format.json {render :json => @shooter}
    end
  end
end
