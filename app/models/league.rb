require 'gsl'

class League < ActiveRecord::Base
  has_many :league_members
  
  def get_results
    members = self.league_members.map{|lm| lm.user_id}.uniq
    member_rounds = []
    # for each member, get the scores
    members.each{|m|
      member_scores = LeagueScore.find_all_by_user_id_and_league_id(m,self.id,:order => "shot_at ASC").map(&:score)
      member_rounds.push(member_scores)
    }
    score_array = []
    for i in (0..member_rounds.size - 1)
      round_scores = []
      member_rounds.each{|r|
        if r.size - 1 >= i
          round_scores.push(r[i])
        else
          round_scores.push(0)
        end
      }
      score_array.push(round_scores)
    end
    return score_array
  end
  
  def scores_for_user(user_id)
    member_scores = LeagueScore.find_all_by_user_id_and_league_id(user_id,self.id,:order => "shot_at ASC").map(&:score)
    member_scores
  end
  
  def minimax
    members = self.league_members.map{|lm| lm.user_id}.uniq
    max = nil
    max_total = 0
    min = nil
    min_total = 0
    # for each member, get the scores
    members.each{|m|
      member_scores = LeagueScore.find_all_by_user_id_and_league_id(m,self.id,:order => "shot_at ASC").map(&:score)
      if member_scores.sum > max_total or max.nil?
        max = member_scores
        max_total = member_scores.sum
      end
      if member_scores.sum <= min_total or min.nil?
        min = member_scores
        min_total = member_scores.sum
      end
    }
    [max,min]
  end
  
  def email_addresses
    members = self.league_members.map{|lm| lm.user_id}.uniq.map{|m| User.find(m).email}
  end
  
  def get_median
    #get all league scores
    scores = LeagueScore.find_all_by_league_id(self.id).map(&:score)
    v = GSL::Vector.alloc(scores)
    return v.median
  end
  
  def get_scores
    #get all league scores
    scores = LeagueScore.find_all_by_league_id(self.id).map(&:score)
    return scores
  end
  
end
