require 'round_end'
require 'round'
class RoundController < ApplicationController
  
  def new
    @shooter = current_user
    leagues = LeagueMember.find_all_by_user_id(@shooter.id).map(&:league_id).uniq
    leagues = League.find(leagues)
    tournaments = TournamentMember.find_all_by_user_id(@shooter.id).map(&:tournament_id).uniq
    tournaments = Tournament.find(tournaments)
    @type_select = [["Practice","practice:0"]]
    leagues.each{|l|
      @type_select.push([l.name,"league:"+l.id.to_s])
    }
    tournaments.each{|t|
      @type_select.push([t.name,"tournament:"+t.id.to_s])
    }
    @round = Round.new
    @possible_scores = Array.new(@round.arrow_score+1) {|i| i}
    
    respond_to do |format|
      format.html 
      format.json {render :json => @round}
    end
  end
  
  def edit_score
    #get the round end from the params
    rend = params["row"].to_i
    rscore = params["cell"].to_i
    new_value = params["value"].to_i
    @round = Round.find(params["id"])
    @editing_end = @round.round_ends.find_by_end_count(rend)
    if ((rscore > 1) and (rscore <= @editing_end.arrow_count+1))
      score_index = rscore-2
      scores = @editing_end.scores.split(",").map{|s| s.to_i}
      scores[score_index] = new_value
      @round.total_score -= @editing_end.end_score
      @editing_end.end_score = scores.sum
      @round.total_score += @editing_end.end_score
      @editing_end.scores = scores.join(",")
      @round.save
      @editing_end.save
      
    elsif (rscore == @editing_end.arrow_count+3)
      @editing_end.x_count = new_value
      @editing_end.save
    end
    respond_to do |format|
      format.json {render :json => new_value}
    end
  end
  
  def results
    @shooter = current_user
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
    @round = Round.find(params["id"])
    
    @round_end = RoundEnd.new
    @possible_scores = Array.new(@round.arrow_score+1) {|i| i}
    puts @possible_scores.join(",")
    if params["last_score"]
      @last_score = params["last_score"].to_i
    else
      @last_score = 0
    end
    
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
  @shooter = current_user
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
    
    @end_performance = LazyHighCharts::HighChart.new('graph') do |f|
        f.options[:chart][:defaultSeriesType]='spline'
        @end_scores.each_with_index do |e,i|
          name = "#{(i+1).ordinalize}-Best Arrow"
          f.series(:name =>name, :data=>e, :yAxis => 0)
        end
        f.options[:xAxis]= {:categories => Array.new(@end_scores.length){|i| i+1}}
        f.options[:title][:text]="End-over-End Perfomance"
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
    @round = Round.new(params[:round])
    round_type = params["round_type"].split(":").first
    type_id = params["round_type"].split(":").last.to_i

    @round_end = RoundEnd.new

    @new_round = Round.create :user_id => current_user.id, :shot_at => Date.today, :total_score => 0, :total_bullseye => 0,
      :end_count => params["round"]["end_count"], :arrow_count => params["round"]["arrow_count"], :arrow_score => params["round"]["arrow_score"]
    @possible_scores = Array.new(@new_round.arrow_score+1) {|i| i}
    if round_type == "league"
      @new_round.league_id = type_id
    elsif round_type == "tournament"
      @new_round.tournament_id = type_id
    end
    @new_round.save
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
    @round_end.user_id = @round.user_id
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
