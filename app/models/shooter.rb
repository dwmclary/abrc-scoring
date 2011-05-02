class Shooter < ActiveRecord::Base
  has_many :rounds
  
  validates :password, :confirmation => true 
  attr_accessor :password_confirmation 
  attr_reader :password
  validate :password_must_be_present 
  
  def Shooter.authenticate(name, email, password)
    shooter = find_by_name(name)
    puts shooter
    if shooter.nil?
      shooter = find_by_email(email)
    end
    if !shooter.nil?
      if shooter.hashed_password == self.encrypt_password(password, shooter.salt) 
        shooter
      end 
    end
  end
  
  def Shooter.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + "arbs" + salt)
  end
  
  #password is a virtual attr
  def password=(password)
    @password = password
    
    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password,salt)
    end
  end
  
  def join_league(league_id)
    lm = LeagueMember.where(:league_id => league_id, :shooter_id => self.id)
    if lm.empty?
      lm = LeagueMember.new
      lm.league_id = league_id
      lm.shooter_id = self.id
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
    tm = TournamentMember.where(:tournament_id => tournament_id, :shooter_id => self.id)
    if tm.empty?
      tm = TournamentMember.new
      tm.tournament_id = tournament_id
      tm.shooter_id = self.id
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
  
  private
    def password_must_be_present 
      errors.add(:password, "Missing password") unless hashed_password.present?
    end
    
    def generate_salt
      self.salt = self.object_id.to_s + rand.to_s
    end
end
