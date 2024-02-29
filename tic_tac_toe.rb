#game board
class Grid
  def self.reset_grid() #class method to create a visual board on the console
    @@top_row =    '   |   |   '
    @@tm_row =     '___|___|___'
    @@mm_row =     '   |   |   '
    @@middle_row = '___|___|___'
    @@bm_row =     '   |   |   '
    @@bottom_row = '   |   |   '
    @@grid = [@@top_row, @@tm_row, @@mm_row, @@middle_row, @@bm_row, @@bottom_row]
  end

  self.reset_grid()

  def draw_grid() # method to actually print the board
    puts @@grid, "\n"
  end
end


# player Class
class Player < Grid #player class with inheritance to the grid class to manipulate the board
  attr_accessor :team, :score, :winner, :move_array, :tie_game, :reset, :computer

  @@all_moves=["tl","tm","tr","ml","mm","mr","bl","bm","br"] # class variable for each movement on the board

  @@move_count = 0 # class variable to count total moves in the game 

  @@winning_combination_arrays=[
    ['tl','tm','tr'],['ml','mm','mr'],['bl','bm','br'],
    ['bl','ml','tl'],['bm','mm','tm'],['br','mr','tr'],
    ['bl','mm','tr'],['br','mm','tl']
  ] #winning compinations is a nested array of the different winning moves Example top right, middle middle, and bottom left makes a diagonal win.

  def initialize(team) # allows player_one be assigned a team (either x or o) and default variables
    @team = team
    @score = 0
    @winner = false
    @tie_game = false
    @move_array = Array.new
    @turn_count = 0
    @reset = false
    @computer = false 
  end

  def team_name #method reiterate team name
    puts "You are on the #{team}\'s team"
  end

  def game_move() #the meat of the code  
    move_switch=false 
    while move_switch == false #loop to allow player to enter only an accurate movement without throwing an error
      if @computer == true #if player chooses to play 1 player turns on computer variable 
        random_number=rand(@@all_moves.count) #random number between 0 and the number of items in the @@all_moves array
        movement= @@all_moves[random_number] #variable movement then is picked from the list of the @@all_moves array
        
      else
        puts "Where do you want to place your #{@team}" # if playing 2 player or for human player 
        movement = gets.chomp #player enters choices listed in how to play 
      end
      
      if @@all_moves.include?(movement.downcase) == false # if player enters anything else they go to the top of the loop to enter a correct movement option
        puts "See how to play for correct movements to enter (ie mm = middle middle spot)"
        
      else #the board is updated with the appropriate team symbol (x or o) in the spot on the board they chose
        @@top_row[1] = @team if movement.downcase == 'tl'
        @@top_row[5] = @team if movement.downcase == 'tm'
        @@top_row[9] = @team if movement.downcase == 'tr'
        @@mm_row[1] = @team if movement.downcase == 'ml'
        @@mm_row[5] = @team if movement.downcase == 'mm'
        @@mm_row[9] = @team if movement.downcase == 'mr'
        @@bm_row[1] = @team if movement.downcase == 'bl'
        @@bm_row[5] = @team if movement.downcase == 'bm'
        @@bm_row[9] = @team if movement.downcase == 'br'
        
        draw_grid() #the updated board is then drawn
    
        @move_array[@turn_count]=movement #the move for the player is then recorded in the move array
        @@all_moves.delete(movement.downcase) # the movement choice is then removed from the all moves array so that it can't be chosen again for this round
        @@all_moves.compact! #the all moves array then has any 'nil's removed
        turn_counter() #see method directly below
        move_switch=true #while loop is broken to continue
        break
      end
    end
  end
  
  def turn_counter #method for adding move to move_array
    @turn_count+=1
    @@move_count+=1
    #puts "It\'s turn number #{@turn_count}"for debugging
  end    


  
  def check_for_win
    if @turn_count >= 3 #no need to run before the ability to win is possible
  
      @move_array.sort! #sorts moves alphabetically
      #puts "#{@move_array}" #for debugging
      @@winning_combination_arrays.any? do |moves| #incrementally goes through winning combinations
      
      #puts "#{moves}" #for debugging
        if (moves-@move_array).empty? #compares winning combinations to @players array of moves
          puts "#{@team} Wins!\n congratulations"
          @winner= true
          game_win() 
        #else puts "NO MATCH" #for debugging
        end
      end
    end
    if @@move_count>=9 && @winner == false #When grid is filled game ends as a tie
      puts "It\'s a tie!!!!!!"
      @tie_game= true
      game_win() # to run through play again response
    end
  end
  
  def game_win
    @score += 1 if @winner == true 
    puts "#{@team}\'s score is #{self.score}"
    @@game_ending_loop = true
    while @@game_ending_loop == true #loop to check if the player wants to play again 
      puts "Do you want to play again? Yes or no only please."
      winner_response = gets.chomp 

      if winner_response.downcase == "yes"        
        reset_game() #method below that resets all the variables to starting values
        draw_grid() #draws a blank board
        @@game_ending_loop = false #breaks loop
        
      elsif winner_response.downcase == "no"
        puts "Adios!" #ends the program is a bye message
        @@game_ending_loop= false
        
      else #only allows yes or no as a response by the user
        puts "Please only enter yes or no."
      end
    end
  end
    
  
  
  def reset_game() #method to reset all the variables to starting values
    @@all_moves=["tl","tm","tr","ml","mm","mr","bl","bm","br",]
    @@move_count = 0
    @winner = false
    @tie_game = false
    @turn_count = 0
    @move_array= Array.new
    @reset = true
    Grid.reset_grid()
  end
end

#start of game
puts "How to Play: Enter in a spot on the grid \n
TL, TM, or TR for the Top row
ML, MM, or MR for the middle row
BL, BM, or BR for the bottom row \n
An X will be placed where you choose
The computer will then choose a spot placing an O
The key is to get 3 Xs vertically, horizontally or diagonally before your opponant
And block your opponant from doing the same
Good Luck!

"

#single player or two human players
choose_game_mode = false
player_2_is_comp = false #default is 2 players
while choose_game_mode == false # loop to only allow 1 or 2 response
  
  puts "1 player or 2 players? Enter 1 or 2"
  number_of_players = gets.chomp.to_s
  
  if number_of_players != "1" && number_of_players != "2"
    puts "Please only enter numerical 1 or 2 thank you!"
    
  elsif number_of_players == "1"
    
    player_2_is_comp = true #for after instances of player are made player_two.computer= true
    choose_game_mode = true
    
  else 
    choose_game_mode = true #leaves @computer as false and breaks loop
  end
end


# player has a team (X or O)
acceptible_team = false
while acceptible_team == false #loop to only allow x or o response
  
  puts "What team do you want to play? X or O"
  team_choice= gets.chomp
  
  if team_choice.upcase != "X" && team_choice.upcase !="O"
    puts "Please only enter X or O"
    
  else
    player_one = Player.new(team_choice.upcase)
    player_one.team_name
    
    # computer object of player class
    if team_choice.upcase == "X"
      player_two = Player.new('O')
      
    else
      player_two= Player.new("X")
    end
    acceptible_team = true
  end
end

#actually when player_two is turned into a computer player based on previous player input
if player_2_is_comp == true
  player_two.computer =  true
end

#make grid object and draw board
grid= Grid.new
grid.draw_grid()

#gameLoop
while player_one.winner == false && player_two.winner == false  && player_one.tie_game == false && player_two.tie_game == false

  player_one.game_move()
  player_one.check_for_win()
  
  if player_one.reset == true
    puts "player one\'s score is #{player_one.score} player_two\'s score is #{player_two.score}"
    player_two.reset_game()
    player_one.reset = false
    player_two.reset = false
  end
  
  if player_one.winner == true || player_one.tie_game == true #breaks game loop if play again response is no
    puts "Final score is player one: #{player_one.score} player_two: #{player_two.score}"
    break
  end

  player_two.game_move()
  player_two.check_for_win()
  
  if player_two.reset == true
    puts "player one\'s score is #{player_one.score} player two\'s score is #{player_two.score}"
    player_one.reset_game()
    player_one.reset = false
    player_two.reset = false
  end
end
