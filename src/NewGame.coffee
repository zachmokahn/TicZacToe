firstPlayer = secondPlayer = board = game = undefined

startGame = ->
  firstPlayerToken = if $('#playerPiece').val() is "X" then "X" else "O"
  secondPlayerToken = if $('#playerPiece').val() is "X" then "O" else "X"
  board = new Board(firstPlayerToken, secondPlayerToken)
  firstPlayer = new Player("firstPlayer")
  secondPlayer = new Computer(board)
  firstMove = $("#firstMove").val()
  console.log(firstMove)
  startingPlayer = if firstMove is "player" then firstPlayer else secondPlayer
  game = new Game(firstPlayer, secondPlayer, board, startingPlayer )
  resetBoard()

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
  if game.turn is secondPlayer
    playerMove(secondPlayer.findBestMove())

setPieces = ->
  count = 0
  for space in board.spaces
    $("div#space#{count}").addClass('cross') if space is "X"
    $("div#space#{count}").addClass('circle') if space is "O"
    count++

$ ->
  $('#newGame').on "click", (event) ->
    startGame()
    checkTurn()

  $('.boardPiece').on "click", (event) ->
    location = this.id.slice(-1)
    playerMove(location)
    checkTurn()
