class Game
  board: [" "," "," "," "," "," "," "," "," "]
  constructor: (@player) ->
  
  playerMove: (position) ->
    @board[position] = "X"

  checkLocation: (position) ->
    @board[position]

window.Game = Game 
