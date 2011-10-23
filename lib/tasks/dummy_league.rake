namespace :league do
  task :dummy => :environment do
    desc "Generate a dummy league with shooters"
    #make a dummy league
    l = League.new
    l.name = "Dummy League"
    l.distance = 15
    l.start_date = Date.today - 10.days
    l.save
    #make 10 dummy shooters
    (1..10).each{|s|
      new_shooter = User.new
      new_shooter.email = "RandomShooter" + s.to_s+"@email.com"
      new_shooter.password = "123456"
      new_shooter.password_confirmation = "123456"
      new_shooter.save!
      new_shooter.join_league(l.id)
      #for this shooter make 10 rounds
      (1..10).each{|r|
        round = Round.new
        round.league_id = l.id
        round.user_id = new_shooter.id
        round.shot_at = Date.today + (r-1)
        round.save
        #generate a random score for this round
        total_score = 0
        (1..10).each{|e|
          score = []
          for i in (1..3) do
            score.push(rand(11))
          end
          rand_end = RoundEnd.new
          rand_end.user_id = new_shooter.id
          rand_end.round_id = round.id
          rand_end.end_count = e
          rand_end.scores = score.join(",")
          rand_end.end_score = score.sum
          rand_end.save
        }
        round.total_score = round.score
        round.save
        ls = LeagueScore.new
        ls.league_id = l.id
        ls.user_id = new_shooter.id
        ls.score = round.total_score
        ls.shot_at = round.shot_at
        ls.save
        
      }
      
    }
  end
end