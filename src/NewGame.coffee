game = undefined

startGame = ->
  name = $('#playerName').val()
  name = "player1" if name is ""
  firstMove =  $('#firstMove').val()
  playerToken = $('#playerPiece').val()
  game = new Game(name, firstMove, playerToken)
  resetBoard()

resetBoard = ->
  for space in [0..8]
    $("div#space#{space}").removeClass('cross')
    $("div#space#{space}").removeClass('circle')


computerMove = ->
  game.computerMove()
  setPieces()

playerMove = (space) ->
  game.playerMove(space)
  setPieces()
  computerMove()

setPieces = ->
  count = 0
  for space in game.board
    $("div#space#{count}").addClass('cross') if space is "X"
    $("div#space#{count}").addClass('circle') if space is "O"
    count++

$ ->
  $('#newGame').on "click", (event) ->
    startGame()
    computerMove() if game.turn is "computer"
    
  $('.boardPiece').on "click", (event) ->
    location = this.id.slice(-1)
    playerMove(location)
