class Game
  constructor: (@player, @turn="player", @playerToken="X") ->
    @board = [" "," "," "," "," "," "," "," "," "]
    @gameOver = false
    if @playerToken is "X"
      @computerToken = "O"
    else
      @computerToken = "X"

  playerMove: (position) ->
    return @gameOverError() if @gameOver
    if @checkLocation(position) is " " && @turn is "player"
      @board[position] = @playerToken
      @changeTurn()
    else
      @illegalTurnError()

  checkLocation: (position) ->
    @board[position]

  computerMove: ->
    return @gameOverError() if @gameOver
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

  checkStatus: ->
    @gameOver = true if @playerWin() || @computerWin() || @isDraw()
    if @gameOver
      return @playerWon() if @playerWin()
      return @computerWon() if @computerWin()
      return @nobodyWon() if @isDraw()


  winnerAlert: (who) ->
    alert("#{who} has won this round")

  playerWin: ->

  playerWon: ->
    @winnerAlert(@player.name)

  computerWin: ->

  computerWon: ->
    @winnerAlert("computer")

  isDraw: ->

  nobodyWon: ->
    @winnerAlert("DRAW: nobody")

  gameOverError: ->
    @raiseError("Illegal Move: the game is over, no more moves allowed")

  illegalTurnError: ->
    @raiseError("Illegal Move: move taken out of turn")

window.Game = Game
