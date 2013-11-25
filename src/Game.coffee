class Game
  board: [" "," "," "," "," "," "," "," "," "]
  constructor: (@player) ->
  
  playerMove: (position) ->
    @board[position] = "X" if @checkLocation(position) is " "

  checkLocation: (position) ->
    @board[position]

  computerMove: ->
    position = @computerLogic()
    @board[position] = "O" if @checkLocation(position) is " "
  
  computerLogic: ->

window.Game = Game
