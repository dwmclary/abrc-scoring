require 'boxplot_box'
class TournamentController < ApplicationController

  def index
    redirect_to :controller => "tournament", :action => "show"
  end
  
  def show
    @shooter = Shooter.find(session[:shooter_id])
    if @shooter.nil?
      puts "shooter is nil"
    end
    if params[:id].nil?
      if @shooter.is_admin
        @tournament = Tournament.order("created_at DESC")
      else
        membership = TournamentMember.where(:shooter_id => @shooter.id).map(&:tournament_id)
        @tournament = Tournament.find(membership)
      end
    else
      @tournament = [Tournament.find(params[:id])]
    end
    respond_to do |format|
      format.html
    end
  end
  
  def scores
    @tournament = Tournament.find(params[:id])
    @tournament_score = TournamentScore.new
    @tournament_score.tournament_id = @tournament.id
    shooter_ids = @tournament.tournament_members.map(&:shooter_id)
    puts shooter_ids
    @tournament_shooters = Shooter.find(shooter_ids)
    if !params[:notice].nil?
      flash[:notice] = params[:notice]
    end
    respond_to do |format|
      format.html
    end
  end
  
  def update
    @tournament = Tournament.find(params[:id])
    @tournament_score = TournamentScore.new(params[:tournament_score])
    added_score = "Failed to add score!"
    if @tournament_score.save
      added_score = "Score added!"
    end
    redirect_to :action => "scores", :id => @tournament.id, :notice => added_score
      
  end
  
  def results
    @shooter = Shooter.find(session[:shooter_id])
    # get all the shooters in the tournament
    
    @tournament = Tournament.find(params[:id])
    # get the scores belonging to this shooter
    shooter_results = TournamentScore.find_all_by_tournament_id(@shooter.id,@tournament.id,:order => "score DESC")
    shooter_names = Shooter.find(shooter_results.map(&:shooter_id)).map(&:name)
    @shooter_scores = shooter_names.zip(shooter_results.map(&:score))
    
    respond_to do |format|
      format.html
    end
  end

  
  def new
    @tournament = Tournament.new
  end
  
  def create
    @shooter = Shooter.find(session[:shooter_id])
    @tournament = Tournament.new(params[:tournament])
    respond_to do |format|
      if @tournament.save
        @tournament = [@tournament]
        format.html {render :action => "show", :id => @tournament.id}
      else
        format.html {render :action => "new"}
      end
    end
  end

end
