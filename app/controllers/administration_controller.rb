require 'fastercsv'
class AdministrationController < ApplicationController
  
  def show
    @admin = current_user
    respond_to do |format|
      format.html
    end
  end
  
  def show_users
    @shooters = User.paginate(:page => params[:page], :per_page => 7)
    respond_to do |format|
      format.html
    end
  end
  
  def show_leagues
    @shooter = current_user
    @round = Round.new
    @league = League.paginate(:page => params[:page], :per_page => 7)
  end
  
  def upload
    shooter = User.find_by_email(params[:email])
    league = League.find(params[:league_id])
    shot_at = Date.new(params[:shot_at]["year"].to_i,params[:shot_at]["month"].to_i,params[:shot_at]["day"].to_i)
    row_index = 0
    scores = []
    x_count = []
    FasterCSV.parse(params[:csv].tempfile) do |row|
      score = row.first
      exes = row.last
      if score.nil?
        break
      end
      scores << score.to_i
      x_count << exes.to_i
      row_index +=1
    end
    total_score = scores.sum
    total_xs = x_count.sum
    ls = LeagueScore.new
    ls.user_id = shooter.id
    ls.league_id = league.id
    ls.score = total_score
    ls.exes = total_xs
    ls.end_scores = scores.map{|s| s.to_s}.join("|")
    ls.save
    flash[:notice] = "Uploaded score of #{ls.score} for #{shooter.email}!"
    redirect_to :controller => "administration", :action => "show_leagues"
  end
  
  def toggle_admin
    @shooter = User.find(params[:user])
    @shooter.is_admin = !@shooter.is_admin
    @shooter.save
    redirect_to :action => "show_users"
  end
  
  def delete_shooter
    @shooter = User.find(params[:user])
    @shooter.destroy
    redirect_to :action => "show_users"
  end
  
end
