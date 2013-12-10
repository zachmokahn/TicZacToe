class Board
  constructor: (@playerToken, @computerToken) ->
    @emptyToken = " "
    @spaces = [" "," "," "," "," "," "," "," "," "]
    @cornerSpots = [0,2,6,8]
    @wallSpots = [1,3,5,7]
    @oppositeSpots = [8,7,6,5,4,3,2,1,0]
    @rows = [[0,1,2],[3,4,5],[6,7,8]]
    @columns = [[0,3,6],[1,4,7],[2,5,8]]
    @diagonals = [[0,4,8],[2,4,6]]

  checkSpot: (location, symbol) ->
    @spaces[location] is symbol

  getSpaces: (locations, symbol) ->
    spot for spot in locations when @checkSpot(spot, symbol)

  playerMove: (location) ->
    @playMove(location, @playerToken)

  computerMove: (location) ->
    @playMove(location, @computerToken)

  playMove: (location, token) ->
    if @validMove(location)
      @spaces[location] = token
    else
      false

   validMove: (location) ->
     @checkSpot(location, @emptyToken)

  checkForWinner: ->
    for player in [@playerToken, @computerToken]
      return player if @checkForWin(player)
    false

  checkForWin: (symbol) ->
    for combos in [@rows, @columns, @diagonals]
      return @hasWinningCombo(combos, symbol) if true
    false

  hasWinningCombo: (combos, symbol) ->
    for combo in combos
      return true if @getSpaces(combo, symbol).length is 3
    false

  checkForDraw: ->
    return true if @noPlayableMoves() and @noWinner()
    false

  noPlayableMoves: ->
    @getSpaces(@oppositeSpots, @emptyToken).length is 0 

  noWinner: ->
    @checkForWinner() is false

window.Board = Board
