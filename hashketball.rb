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
  hash
end

def big_shoe_rebounds 
  #find player with largest shoe size and return their rebounds
  player_array.max_by {|player_hash| player_hash[:shoe]}[:rebounds]
end

#bonus

def most_points_scored
  #return the player who scored the most points
  player_array.max_by {|player_hash| player_hash[:points]}[:player_name]
end

def point_total(side)
    game_hash[side][:players].reduce(0) {|total, player_hash| total + player_hash[:points]}
end

def winning_team
  #return the team that scored the most points
  winning_array = game_hash.max_by {|(side, info_hash)| point_total(side)}
  winning_array[1][:team_name]
end

def player_with_longest_name
  #return the player with the longest name
  player_array.max_by {|player_hash| player_hash[:player_name].length}[:player_name]
end

def long_name_steals_a_ton?
  #return true if the player with the longest name also had the most steals
  player_array.max_by {|player_hash| player_hash[:steals]}[:player_name] == player_with_longest_name 
end
  