def game_hash
  {
    home: {
      team_name: "Brooklyn Nets",
      colors: ["Black", "White"],
      players: [
        {
          player_name: "Alan Anderson",
          number: 0,
          shoe: 16,
          points: 22,
          rebounds: 12,
          assists: 12,
          steals: 3,
          blocks: 1,
          slam_dunks: 1
        }, {
          player_name: "Reggie Evans",
          number: 30,
          shoe: 14,
          points: 12,
          rebounds: 12,
          assists: 12,
          steals: 12,
          blocks: 12,
          slam_dunks: 7
        }, {
          player_name: "Brook Lopez",
          number: 11,
          shoe: 17,
          points: 17,
          rebounds: 19,
          assists: 10,
          steals: 3,
          blocks: 1,
          slam_dunks: 15
        }, {
          player_name: "Mason Plumlee",
          number: 1,
          shoe: 19,
          points: 26,
          rebounds: 11,
          assists: 6,
          steals: 3,
          blocks: 8,
          slam_dunks: 5
        }, {
          player_name: "Jason Terry",
          number: 31,
          shoe: 15,
          points: 19,
          rebounds: 2,
          assists: 2,
          steals: 4,
          blocks: 11,
          slam_dunks: 1
        }
      ]
    },
      
    away: {
      team_name: "Charlotte Hornets",
      colors: ["Turquoise", "Purple"],
      players: [
        {
          player_name: "Jeff Adrien",
          number: 4,
          shoe: 18,
          points: 10,
          rebounds: 1,
          assists: 1,
          steals: 2,
          blocks: 7,
          slam_dunks: 2
        }, {
          player_name: "Bismack Biyombo",
          number: 0,
          shoe: 16,
          points: 12,
          rebounds: 4,
          assists: 7,
          steals: 22,
          blocks: 15,
          slam_dunks: 10
        }, {
          player_name: "DeSagna Diop",
          number: 2,
          shoe: 14,
          points: 24,
          rebounds: 12,
          assists: 12,
          steals: 4,
          blocks: 5,
          slam_dunks: 5
        }, {
          player_name: "Ben Gordon",
          number: 8,
          shoe: 15,
          points: 33,
          rebounds: 3,
          assists: 2,
          steals: 1,
          blocks: 1,
          slam_dunks: 0
        }, {
          player_name: "Kemba Walker",
          number: 33,
          shoe: 15,
          points: 6,
          rebounds: 12,
          assists: 12,
          steals: 7,
          blocks: 5,
          slam_dunks: 12
        }
      ]
    }
  }
end

def player_array
  game_hash[:home][:players] + game_hash[:away][:players]
end

def side_hash(team)
  #returns the hash of all team info by team name
  side_array = game_hash.find {|(side, info_hash)| info_hash[:team_name] == team}
  side_array[1]
end

def num_points_scored(player)
  #search for a player by name and return the number of points they scored
  player_array.find {|player_hash| player_hash[:player_name] == player}[:points]
end

def shoe_size(player)
  #search for a player by name and return their shoe size
  player_array.find {|player_hash| player_hash[:player_name] == player}[:shoe]
end

def team_colors(team)
  #returns the team colors of a given team
  side_hash(team)[:colors]
end

def team_names
  game_hash.map {|(side, info_hash)| info_hash[:team_name]}
end

def player_numbers(team)
  #returns an array of the player numbers of the given team
  side_hash(team)[:players].map {|player_hash| player_hash[:number]}
end
      
def player_stats(player)
  #returns the stats for a given player
  hash = player_array.find {|player_hash| player_hash[:player_name] == player}
  hash.delete :player_name
end

def big_shoe_rebounds #find player with largest shoe size and return their rebounds
  find_max(:shoe, :rebounds)
end

#bonus

def most_points_scored
  find_max(:points, :player_name)
end

def find_max(to_compare, to_return)
  maximum = game_hash.reduce({}) do |memo, (side, info_hash)|
    memo = info_hash[:players][0] if !memo[to_compare]
    max_hash = info_hash[:players].max_by {|player_hash| player_hash[to_compare]}
    memo = max_hash if max_hash[to_compare] > memo[to_compare]
    memo
  end
  maximum[to_return]
end

def point_total(side)
  game_hash[side][:players].reduce(0) do |total, player_hash|
    total += player_hash[:points]
  end
end

def winning_team
  home_points = point_total(:home)
  away_points = point_total(:away)
  if home_points > away_points
    return game_hash[:home][:team_name]
  else
    return game_hash[:away][:team_name]
  end
end

def player_with_longest_name
  find_longest = game_hash.reduce({}) do |memo, (side, info_hash)|
    memo = info_hash[:players][0] if !memo[:player_name]
    longest_hash = info_hash[:players].max_by {|player_hash| player_hash[:player_name].length}
    memo = longest_hash if longest_hash[:player_name].length > memo[:player_name].length
    memo
  end
  find_longest[:player_name]
end

def long_name_steals_a_ton?
  player_key = player_with_longest_name
  best_stealer = find_max(:steals, :player_name)
  player_key == best_stealer
end
  