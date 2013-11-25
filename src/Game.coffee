class Game
  board: [" "," "," "," "," "," "," "," "," "]
  constructor: (@player) ->
  
  playerMove: (position) ->
    @board[position] = "X"

  checkLocation: (position) ->
    @board[position]

  computerMove: ->
    location = @computerLogic()
    @board[location] = "O"
  
  computerLogic: ->

window.Game = Game
