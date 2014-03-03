require 'sinatra'
require 'shotgun'

def who_won (score)
  if score[:home_score] > score[:away_score]
    return score[:home_team]
  else
    return score[:away_team]
  end
end

def who_lost (score)
  if score[:home_score] < score[:away_score]
    return score[:home_team]
  else
    return score[:away_team]
  end
end

get '/leaderboard' do

  @teams = [
    { team_name: "Patriots",
      win_count: 0,
      loss_count: 0
    },
    { team_name: "Broncos",
      win_count: 0,
      loss_count: 0
    },
    { team_name: "Steelers",
      win_count: 0,
      loss_count: 0
    },
    { team_name: "Colts",
      win_count: 0,
      loss_count: 0
    },
  ]


  @scores = [
    {
      home_team: "Patriots",
      away_team: "Broncos",
      home_score: 7,
      away_score: 3
    },
    {
      home_team: "Broncos",
      away_team: "Colts",
      home_score: 3,
      away_score: 0
    },
    {
      home_team: "Patriots",
      away_team: "Colts",
      home_score: 11,
      away_score: 7
    },
    {
      home_team: "Steelers",
      away_team: "Patriots",
      home_score: 7,
      away_score: 21
    }
  ]

  @scores.each do |score|
      score[:winner] = who_won(score)
      score[:loser] = who_lost(score)
      @teams.each do |team|
        if score[:winner] == team[:team_name]
          team[:win_count]+=1
        end
        if score[:loser] == team[:team_name]
          team[:loss_count]+=1
        end
      end
  end

  erb:index
end
