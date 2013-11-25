class Game
  constructor: (@player) ->
    @board = [" "," "," "," "," "," "," "," "," "]
    @turn = "player"

  playerMove: (position) ->
    if @checkLocation(position) is " " && @turn is "player"
      @board[position] = "X"
      @changeTurn()
    else
      @illegalTurnError()

  checkLocation: (position) ->
    @board[position]

  computerMove: ->
    position = @computerLogic()
    if @checkLocation(position) is " " && @turn is "computer"
      @board[position] = "O"
      @changeTurn()
    else
      @illegalTurnError()

  changeTurn: ->
    @turn = if @turn is "player" then "computer" else "player"
  
  computerLogic: ->
  
  raiseError: (call) ->
    alert(call)
  
  illegalTurnError: ->
    @raiseError("Illegal Move: move taken out of turn")

window.Game = Game
