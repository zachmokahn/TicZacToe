mode = firstPlayerToken = secondPlayerToken = startingPlayer = firstPlayer = secondPlayer = board = game = undefined

startGame = ->
  resetBoard()
  getGameMode()
  assignPlayerTokens()
  createNewBoard()
  assignPlayers()
  assignFirstMove()
  startNewGame()

getGameMode = ->
  mode = $("#gameMode").val()

assignPlayerTokens = ->
  firstPlayerToken = if $('#playerPiece').val() is "X" then "X" else "O"
  secondPlayerToken = if $('#playerPiece').val() is "X" then "O" else "X"

createNewBoard = ->
  board = new Board(firstPlayerToken, secondPlayerToken)

assignPlayers = ->
  firstPlayer = new Player("firstPlayer")
  secondPlayer = if mode is "twoPlayer" then new Player("secondPlayer") else new Computer(board)

assignFirstMove = ->
  firstMove = $("#firstMove").val()
  startingPlayer = if firstMove is "player" then firstPlayer else secondPlayer

startNewGame = ->
  game = new Game(firstPlayer, secondPlayer, board, startingPlayer )

resetBoard = ->
  for space in [0..8]
    $("div#space#{space}").removeClass('cross')
    $("div#space#{space}").removeClass('circle')

playerMove = (space) ->
  unless game.gameOver
    game.playerMove(space)
    setPieces()
    gameResults()

gameResults = ->
  game.checkGameOver()
  if game.gameOver
    alert("#{game.winner} wins!")

checkTurn = ->
  if game.turn is secondPlayer and mode is "singlePlayer"
    playerMove(secondPlayer.findBestMove())

setPieces = ->
  count = 0
  for space in board.spaces
    $("div#space#{count}").addClass('cross') if space is "X"
    $("div#space#{count}").addClass('circle') if space is "O"
    count++

getLocation = (that) ->
  location = that.id.slice(-1)

$ ->
  $('#newGame').on "click", (event) ->
    startGame()
    checkTurn()

  $('.boardPiece').on "click", (event) ->
    playerMove(getLocation(this))
    checkTurn()
