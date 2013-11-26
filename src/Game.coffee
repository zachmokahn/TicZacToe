class Game
  constructor: (@player) ->
    @board = [[" "," "," "],[" "," "," "],[" "," "," "]]
    @turn = "player"
    @gameOver = false
  
  playerMove: (row,index) ->
    return @gameOverError() if @gameOver
    if @checkLocation(row,index) is " " && @turn is "player"
      row = @board[row]
      row[index] = "X"
      @changeTurn()
    else
      @illegalTurnError()

  checkLocation: (row,index) ->
    row = @board[row]
    row[index]

  computerMove: ->
    return @gameOverError() if @gameOver
    location = @computerLogic()
    row = location[0]
    index = location[1]
    if @checkLocation(row,index) is " " && @turn is "computer"
      @board[row][index] = "O"
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
