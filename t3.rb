require "pry"

board = [8,1,6,3,5,7,4,9,2]

def greeting(board)
  puts
	puts "Welcome to Magic Square Tic Tac Toe."
	sleep 1.5
	puts 
	puts "Please choose an option below:"
	puts "======================================================="
	puts "| 1. Play                                             |"
	puts "|     Try to get 3 numbers that add up to 15.         |"
	puts "| 2. Instructions                                     |"
	puts "|     Learn how to play                               |"
	puts "| 3. About                                            |"
	puts "|     Some info about the author of this code         |"
	puts "| 4. Exit                                             |"
	puts "|     Leave the game                                  |"
	puts "======================================================="
	puts

	selection = gets.chomp.to_i

	until (1..5).include?(selection)
		puts "Please select an option 1 - 3."
		selection = gets.chomp.to_i
	end
	
	case selection 
		when 1 
			play_game(board)
		when 2
			instructions(board)
		when 3
			about(board)
		when 4
			exit
		else
			puts "Please select an option 1 - 3."
	end
end

def instructions(board)
	puts
	puts "X always goes first."
	puts
	puts "Players alternate placing Xs and Os on the board until either "
	puts "(a) one player has three in a row, horizontally, vertically or diagonally; or "
	puts "(b) all nine squares are filled."
	puts
	puts "If a player is able to draw three Xs or three Os in a row, that player wins."
	puts
	puts "If all nine squares are filled and neither player has three in a row, "
	puts "the game is a draw."
	
	greeting(board)
end

def about(board)
	puts
	puts "Game created by Keith Nash. You can see more of my work at Tallkeith.com, "
	puts "or checkout my github repo at github.com/tallkeith"
	puts
	puts "I am tall. Like, REALLY tall. I am between 6'6 and 6'9, "
	puts "depending on which convenience store I am walking out of."
	puts
	puts "I like Bacon, Star Wars, and Cake. I will go to great lengths for cake. "
	puts "I attend weddings of people I do not like, because I know they will give me cake."
	puts

	greeting(board)
end

def show_board(board)
	puts
	puts "---------"
	3.times do |row|
		puts board[row * 3, 3].join(" | ")
		puts "---------"
	end
	puts
	puts
end

def player_move(player_array, comp_array, board)
	puts "Please select a square 1-9"
	choice = gets.chomp.to_i
	until (1..9).include?(choice) && !player_array.include?(choice) && !comp_array.include?(choice)
		puts "Selection must be a number 1-9 that hasn't been chosen yet"
		sleep 0.5
		show_board(board)
		choice = gets.chomp.to_i
	end
	choice
end

def comp_move(board)
  place = available_moves(board).sample
end

def available_moves(board)
	board.select { |piece| piece.is_a?(Fixnum) }
end

def magic_win?(moves)
	winner = false
	moves.combination(3).each do |combo|
  	winner = true if combo.reduce(:+) == 15 && combo.length >= 3
	end
	winner
end

def draw(board, player_array)
	board.all? { |piece| piece.is_a?(String) } && !magic_win?(player_array)
end

def game_over?(player_array, comp_array, board)
	magic_win?(player_array) || magic_win?(comp_array) || draw(board, player_array)
end

def finish_game(current_player, comp, player, board, player_array)
	show_board(board)
	if draw(board, player_array)
		puts "Tie game"
	elsif current_player == comp
		puts "Congratulations, you win!"
	else 
		puts "You lose. Better luck next time"
	end
	play_again?
end

def play_again?
	board = [8,1,6,3,5,7,4,9,2]
	puts "Would you like to play again? y/n"
	choice = gets.chomp.downcase
	until ["y", "n"].include?(choice)
		puts "Please choose 'Y' or 'N'"
		choice = gets.chomp.downcase
	end
	if choice == "y"
		play_game(board)
	else
		puts "Thanks for checking out my game! I hope you had fun!"
	end
end

def play_game(board)
	
	player_array = []
	player = "X"
	comp_array = []
	comp = "O"
	current_player = player
	until game_over?(player_array, comp_array, board)
		show_board(board)
		if current_player == player
			puts "Human Player's turn"
			puts "Your numbers are: #{player_array}"
			choice = player_move(player_array, comp_array, board)
			player_array.push(choice)
		  spot = board.index(choice)
			board[spot] = player
			current_player = comp
		else
			place = comp_move(board)
			marker = board.index(place)
			board[marker] = comp
			comp_array.push(place)
			sleep 0.5
			puts "Computer selects #{place}"
			current_player = player
		end	
	end
	finish_game(current_player, comp, player, board, player_array)
end

greeting(board)