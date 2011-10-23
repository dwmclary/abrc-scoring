class User < ActiveRecord::Base

  has_many :rounds
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  def join_league(league_id)
    lm = LeagueMember.where(:league_id => league_id, :user_id => self.id)
    
    if lm.empty?
      lm = LeagueMember.new
      lm.league_id = league_id
      lm.user_id = self.id
      
      if lm.save
        return true
      else
        return false
      end
    else
      return true
    end
  end
  
  def enter_tournament(tournament_id)
    tm = TournamentMember.where(:tournament_id => tournament_id, :user_id => self.id)
    if tm.empty?
      tm = TournamentMember.new
      tm.tournament_id = tournament_id
      tm.user_id = self.id
      if tm.save
        return true
      else
        return false
      end
    else
      return true
    end
  end
  
  def average_score
    scores = []
    self.rounds.each{|r|
      scores.push(r.total_score)
    }
    return scores.sum.to_f / scores.size
  end
  
  def get_best_score
    self.best_score = self.rounds.map(&:total_score).max
    self.save
  end
  
  def average_bullseyes
    bullseyes = []
    self.rounds.each{|r|
      scores.push(r.total_bullseye)
    }
    return bullseyes.sum.to_f / bullseyes.size
  end
  
  def is_admin
    return self.admin
  end
end
