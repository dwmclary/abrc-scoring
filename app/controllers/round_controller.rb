require 'round_end'
require 'round'
class RoundController < ApplicationController
  SCORES_ARRAY = Array.new(11) {|i| i}
  
  def new
    puts session[:shooter_id]
    @possible_scores = SCORES_ARRAY
    @round = Round.new
    respond_to do |format|
      format.html 
      format.json {render :json => @round}
    end
  end
  
  def results
    @round = Round.find(params["id"])
    @round_ends = @round.round_ends
    rends = @round_ends.map{|r| r.scores.split(",").map{|i| i.to_i}}
    @end_scores = []
    @total_scores = []
    for r in rends
      @total_scores.push(r.sum)
    end
    for i in Range.new(0,rends.first.size-1)
      entry = []
      for j in Range.new(0,rends.size-1)
        entry.push(rends[j][i])
      end
      @end_scores.push(entry)
    end

    respond_to do |format|
      format.html 
      format.json {render :json => @end_scores}
    end
  end
  
  def show
    @round_end = RoundEnd.new
    @possible_scores = SCORES_ARRAY
    if params["last_score"]
      @last_score = params["last_score"].to_i
    else
      @last_score = 0
    end
    
    @round = Round.find(params["id"])
    @round_end.round_id = @round.id
    @score_sheet = @round.round_ends
    # puts @score_sheet.size
    respond_to do |format|
      format.html
      format.js
      format.json {render :json => @round}
    end
  end
  
  def show_ends
   @round = Round.find(params["id"])
    @round_ends = @round.round_ends
    rends = @round_ends.map{|r| r.scores.split(",").map{|i| i.to_i}}
    @end_scores = []
    @total_scores = []
    for r in rends
      @total_scores.push(r.sum)
    end
    for i in Range.new(0,rends.first.size-1)
      entry = []
      for j in Range.new(0,rends.size-1)
        entry.push(rends[j][i])
      end
      @end_scores.push(entry)
    end
    respond_to do |format|
      format.html
    end
  end
  
  def show_score
    @round = Round.find(params[:id])
    @score_sheet = @round.round_ends
    respond_to do |format|
      format.html
    end
  end
  
  def show_dist
    @round = Round.find(params[:id])
    @shots = @round.shots
    respond_to do |format|
      format.html
    end
  end
  
  def show_shots
    @round = Round.find(params["id"])
     @round_ends = @round.round_ends
     rends = @round_ends.map{|r| r.scores.split(",").map{|i| i.to_i}}
     @end_scores = []
     @total_scores = []
     for r in rends
       @total_scores.push(r.sum)
     end
     for i in Range.new(0,rends.first.size-1)
       entry = []
       for j in Range.new(0,rends.size-1)
         entry.push(rends[j][i])
       end
       @end_scores.push(entry)
     end
  end
  
  def create
    @round_end = RoundEnd.new
    @possible_scores = SCORES_ARRAY
    @new_round = Round.create :shooter_id => session[:shooter_id], :shot_at => Date.today, :total_score => 0, :total_bullseye => 0, :end_count => params["round"]["end_count"], :arrow_count => params["round"]["arrow_count"]
    @score_sheet = @new_round.round_ends
    respond_to do |format|
      format.html {redirect_to :controller => :round, :action => :show, :id => @new_round.id}
      format.json {render :json => @round}
    end
  end
  
  def update
    @round_end = RoundEnd.new
    @round_end.round_id = params["round_end"]["round_id"]
    @round = Round.find(@round_end.round_id)
    @round_end.shooter_id = @round.shooter_id
    scores = []
    for s in params["shot"].keys do
          if s != "x"
            scores.push(params["shot"][s].to_i)
          else
            @round_end.x_count = params["shot"][s].to_i
          end
    end
    last_score = scores.last
    @round_end.scores = scores.join(",")
    @round_end.end_score = scores.sum
    @round_end.end_count = RoundEnd.count(:conditions => ["round_id = (?)",@round_end.round_id]) + 1
    if @round_end.end_count == @round.end_count
      @round.total_score = @round.score
      @round.total_bullseye = @round.bullseyes
      @round.save
    end
    @round_end.save
    puts "saved with id " + @round_end.id.to_s
    respond_to do |format|
      format.html {redirect_to :controller => :round, :action => :show, :id => @round_end.round_id, :last_score => last_score}
      format.js
    end
  end
  
end
