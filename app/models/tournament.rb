require 'gsl'

class Tournament < ActiveRecord::Base
  has_many :tournament_members
  
  def get_results
    members = self.tournament_members.map{|lm| lm.shooter_id}.uniq
    member_rounds = []
    # for each member, get the scores
    members.each{|m|
      member_scores = TournamentScore.find_all_by_shooter_id_and_tournament_id(m,self.id).map(&:score)
      member_rounds.push(member_scores)
    }
    score_array = member_rounds.flatten
    return score_array
  end
  
  def get_median
    #get all tournament scores
    scores = TournamentScore.find_all_by_tournament_id(self.id).map(&:score)
    v = GSL::Vector.alloc(scores)
    return v.median
  end
  
  def get_scores
    #get all tournament scores
    scores = TournamentScore.find_all_by_tournament_id(self.id).map(&:score)
    return scores
  end
end
