require "pry"

board = [8,1,6,3,5,7,4,9,2]

def greeting
  puts
  puts "Welcome to Magic Square Tic Tac Toe!"
  puts "Try to get three numbers that equal 15 to win..."
  puts
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
	puts "Would you like to play again?"
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
	greeting
	player_array = []
	player = "X"
	comp_array = []
	comp = "O"
	current_player = player
	until game_over?(player_array, comp_array, board)
		show_board(board)
		if current_player == player
			puts "Human Player's turn"
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

play_game(board)

