require 'boxplot_box'
class LeagueController < ApplicationController
  
  def index
    redirect_to :controller => "league", :action => "show"
  end
  
  def show
    @shooter = Shooter.find(session[:shooter_id])
    if params[:id].nil?
      if @shooter.is_admin
        @league = League.order("created_at DESC")
      else
        membership = LeagueMember.where(:shooter_id => @shooter.id).map(&:league_id)
        puts membership
        @league = League.find(membership)
      end
    else
      @league = [League.find(params[:id])]
    end
    respond_to do |format|
      format.html
    end
  end
  
  def scores
    @league = League.find(params[:id])
    @league_score = LeagueScore.new
    @league_score.league_id = @league.id
    shooter_ids = @league.league_members.map(&:shooter_id)
    @league_shooters = Shooter.find(shooter_ids)
    if !params[:notice].nil?
      flash[:notice] = params[:notice]
    end
    respond_to do |format|
      format.html
    end
  end
  
  def update
    @league = League.find(params[:id])
    @league_score = LeagueScore.new(params[:league_score])
    added_score = "Failed to add score!"
    if @league_score.save
      added_score = "Score added!"
    end
    redirect_to :action => "scores", :id => @league.id, :notice => added_score
      
  end
  
  def results
    @shooter = Shooter.find(session[:shooter_id])
    # get all the shooters in the league
    
    @league = League.find(params[:id])
    # get the scores belonging to this shooter
    @shooter_scores = LeagueScore.find_all_by_shooter_id_and_league_id(@shooter.id,@league.id).map(&:score)
    
    @score_array = @league.get_results
    @boxes = []
    count = 1
    for s in @score_array
      v = GSL::Vector.alloc(s)
      b = BoxplotBox.new
      median = v.median
      b.median = median
      uq_vec = GSL::Vector.alloc(s[s.length/2 .. s.length-1])
      lq_vec = GSL::Vector.alloc(s[0 .. s.length/2-1])
      b.uq=uq_vec.median
      b.lq = lq_vec.median
      b.min = v.min
      b.max = v.max
      b.id = count
      count += 1
      @boxes.push(b)
    end
    @median = @league.get_median
    scores = @score_array.flatten
    @max = scores.max
    @min = scores.min
    
    respond_to do |format|
      format.html
    end
  end

  
  def new
    @league = League.new
  end
  
  def create
    @shooter = Shooter.find(session[:shooter_id])
    @league = League.new(params[:league])
    respond_to do |format|
      if @league.save
        @league = [@league]
        format.html {render :action => "show"}
      else
        format.html {render :action => "new"}
      end
    end
  end
  
end
