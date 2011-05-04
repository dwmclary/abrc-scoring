class ShooterController < ApplicationController
  skip_before_filter :authorize, :only => [:new, :create]
  def create
    @shooter = Shooter.new(params[:shooter])
    @old_rounds = []
    @league = League.new
    @tournament = Tournament.new
    if !params[:notice].nil?
      if params[:notice_type] == "notice"
        flash[:notice] = params[:notice]
      elsif params[:notice_type] == "success"
        flash[:success] = params[:success]
      elsif params[:notice_type] == "error"
        flash[:error] = params[:error]
      end
    end
    respond_to do |format|
      if @shooter.save
        session[:shooter_id] = @shooter.id
        format.html {render :action => "show", :id => @shooter.id}
      else
        format.html {render :action => "new"}
      end
    end
  end
  
  def new
    @shooter = Shooter.new
    @league = League.new
    @tournament = Tournament.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @shooter }
    end
  end
  
  def show
    @shooter = Shooter.find(session[:shooter_id])
    puts @shooter
    @old_rounds = @shooter.rounds.map{|r| {"id"=>r.id,"date"=>r.shot_at}}
    if !@old_rounds.empty? and @shooter.best_score == 0
      @shooter.get_best_score
    end
      
    @league = League.new
    @tournament = Tournament.new
    if !params[:notice].nil?
      if params[:notice_type] == "notice"
        flash[:notice] = params[:notice]
      elsif params[:notice_type] == "success"
        flash[:success] = params[:success]
      elsif params[:notice_type] == "error"
        flash[:error] = params[:error]
      end
    end
    respond_to do |format|
      format.html
      format.json {render :json => @shooter}
    end
  end
  
  def join_league
    id = params[:league_id]
    shooter = Shooter.find(session[:shooter_id])
    state = "error"
    if !League.exists?(id)
      join_string = "No such league to join"
      state = "notice"
    else
      if shooter.join_league(id)
        join_string = "League joined!"
        state = "success"
      else
        join_string = "Error joining league"
        state = "error"
      end
    end
    redirect_to :action => "show", :notice => join_string, :notice_type => state
  end
  
  def enter_tournament
    id = params[:tournament_id]
    shooter = Shooter.find(session[:shooter_id])
    if !Tournament.exists?(id)
      join_string = "No such tournament to enter"
      state = "notice"
    else
      if shooter.enter_tournament(id)
        join_string = "Tournament Entered!"
        state = "success"
      else
        join_string = "Error entering tournament"
        state = "error"
      end
    end
    redirect_to :action => "show", :notice => join_string, :notice_type => state
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
