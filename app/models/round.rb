class Round < ActiveRecord::Base
  has_many :round_ends
  
  def average_end_score
    end_scores = []
    self.round_ends.each{|e|
      scores = e.scores.split(",").map{|i| i.to_i}
      end_scores.push(scores.sum)
    }
    return (end_scores.sum.to_f / end_scores.size)
  end
  
  def average_best_arrow
    best_scores = []
    self.round_ends.each{|e|
      scores = e.scores.split(",").map{|i| i.to_i}
      best_scores.push(scores.max)
    }
    return (best_scores.sum.to_f/best_scores.size)
  end
  
  def average_worst_arrow
    worst_scores = []
    self.round_ends.each{|e|
      scores = e.scores.split(",").map{|i| i.to_i}
      worst_scores.push(scores.min)
    }
    return (worst_scores.sum.to_f/worst_scores.size)
  end
  
  def score
    total_score = 0
    self.round_ends.each{|e|
      total_score += e.end_score
    }
    return total_score
  end
  
  def bullseyes
    total_bullseyes = 0
    self.round_ends.each{|e|
      total_bullseyes += e.x_count
    }
    return total_bullseyes
  end
  
  def shots
    shots = []
    self.round_ends.each{|e|
      shots.push(e.scores.split(",").map{|s| s.to_i})
    }
    return shots.flatten
  end
end
