class Shooter < ActiveRecord::Base
  has_many :rounds
  
  validates :password, :confirmation => true 
  attr_accessor :password_confirmation 
  attr_reader :password
  validate :password_must_be_present 
  
  def Shooter.authenticate(name, password) 
    if shooter = find_by_name(name)
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
  
  def average_score
    scores = []
    self.rounds.each{|r|
      scores.push(r.total_score)
    }
    return scores.sum.to_f / scores.size
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
