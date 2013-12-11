class Game
  constructor: (@firstPlayer, @secondPlayer, @board, firstTurn=@firstPlayer) ->
    @gameOver = false
    @turn = firstTurn

  playerMove: (location) ->
    result = @board.firstPlayerMove(location) if @turn is @firstPlayer
    result = @board.secondPlayerMove(location) if @turn is @secondPlayer
    @changeTurn() if result
    result

  changeTurn: ->
    @turn = if @turn is @firstPlayer then @secondPlayer else @firstPlayer

  checkGameOver: ->
    @winner = @board.checkForWinner()
    @gameOver = true unless @winner is false
    if @board.checkForDraw()
      @gameOver = true
      @winner = "Nobody"
window.Game = Game
