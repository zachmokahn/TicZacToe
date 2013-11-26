class Computer
  constructor: (@computerToken, @playerToken) ->

  cornerSpots: [0,2,6,8]
  wallSpots: [1,3,5,7]
  oppositeSpots: [8,7,6,5,4,3,2,1,0]
  rows: [[0,1,2],[3,4,5],[6,7,8]]
  columns: [[0,3,6],[1,4,7],[2,5,8]]
  diagonals: [[0,4,8],[2,4,6]]

  gameLogic: (@board) ->
    return @winningLocation() if @winningLocation()
    return @blockLocation() if @blockLocation()
    return @blockDoubleThreatLocation() if @blockDoubleThreatLocation()
    return @playCenterLocation() if @playCenterLocation()
    return @playOppositeCornerLocation() if @playOppositeCornerLocation()
    return @playAnyCornerLocation() if @playAnyCornerLocation()
    return @playWallLocation() if @playWallLocation()

  winningLocation: ->
    @checkForWin(@computerToken)

  blockLocation: ->
    @checkForWin(@playerToken)

  checkForWin: (symbol) ->
    return @check(symbol, @rows) if @check(symbol, @rows)
    return @check(symbol, @columns) if @check(symbol, @columns)
    return @check(symbol, @diagonals) if @check(symbol, @diagonals)
  check: (symbol, values)  ->
    for value in values
      return @checkWin(symbol, value) if @checkWin(symbol, value)

  checkWin: (symbol, list) ->
    @checkSpaces(list, " ") if @checkSpaces(list, symbol).length is 2 and @checkSpaces(list, " ").length is 1

  blockDoubleThreatLocation: ->
    @checkSpaces(@wallSpots, " ") if @doubleThreatPresent()

  doubleThreatPresent: ->
    corners = @checkSpaces([0,2], @playerToken)
    doubleThreat = @checkSpaces((@oppositeSpots[spot] for spot in corners), @playerToken)
    return true if doubleThreat.length > 0

  playCenterLocation: ->
    @checkSpaces([4], " ") if @checkSpaces([4], " ").length > 0

  playOppositeCornerLocation: ->
    @getUnoccupiedOpposites(@checkSpaces(@cornerSpots, @playerToken)) if @getUnoccupiedOpposites(@checkSpaces(@cornerSpots, @playerToken)).length > 0

  getUnoccupiedOpposites: (coordinates) ->
    @checkSpaces((@oppositeSpots[spot] for spot in coordinates), " ")

  playAnyCornerLocation: ->
    @checkSpaces(@cornerSpots, " ") if @checkSpaces(@cornerSpots, " ").length > 0

  playWallLocation: ->
    @checkSpaces(@wallSpots, " ") if @checkSpaces(@wallSpots, " ").length > 0

  checkSpaces: (coordinates, character) ->
    spot for spot in coordinates when @board[spot] is character

window.Computer = Computer
