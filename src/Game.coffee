class Game
  constructor: (@player="player1", @turn="player", @playerToken="X") ->
    @moveCount = 0
    @board = [" "," "," "," "," "," "," "," "," "]
    @gameOver = false
    if @playerToken is "X"
      @computerToken = "O"
    else
      @computerToken = "X"
    @ai = new Computer(@computerToken, @playerToken)

  playerMove: (position) ->
    if @checkLocation(position) is " " && @turn is "player"
      @moveCount++
      @board[position] = @playerToken
      if @checkIfWon(@playerToken)
        @playerWon()
        @gameOver = true
      return @nobodyWon() if @moveCount is 9
      @changeTurn()

  checkLocation: (position) ->
    @board[position]

  computerMove: ->
    position = @computerLogic()
    if @checkLocation(position) is " " && @turn is "computer"
      @moveCount++
      @board[position] = @computerToken 
      if @checkIfWon(@computerToken)
        @computerWon()
        @gameOver = true
      return @nobodyWon() if @moveCount is 9
      @changeTurn()

  changeTurn: ->
    @turn = if @turn is "player" then "computer" else "player"

  computerLogic: ->
    @ai.gameLogic(@board)[0]

  winnerAlert: (who) ->
    alert("#{who} has won this round")

  checkIfWon: (token) ->
    for combos in [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
      return true if @ai.checkSpaces(combos, token, @board).length is 3
    @gameOver = true if @moveCount is 9
    false
  
  playerWon: ->
    @winnerAlert(@player.name)

  computerWon: ->
    @winnerAlert("computer")

  nobodyWon: ->
    @winnerAlert("DRAW: nobody")

window.Game = Game
