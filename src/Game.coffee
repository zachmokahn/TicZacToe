class Game
  constructor: (@player) ->
    @board = [" "," "," "," "," "," "," "," "," "]
    @turn = "player"

  playerMove: (position) ->
    if @checkLocation(position) is " "
      @board[position] = "X"
      @changeTurn()

  checkLocation: (position) ->
    @board[position]

  computerMove: ->
    position = @computerLogic()
    if @checkLocation(position) is " "
      @board[position] = "O"
      @changeTurn()

  changeTurn: ->
    @turn = if @turn is "player" then "computer" else "player"
  
  computerLogic: ->

window.Game = Game
