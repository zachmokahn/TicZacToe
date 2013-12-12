class Computer
  constructor: (@board) ->
  readSpaces: ->
    @board.spaces

  findBestMove: ->
    return @bestMove if @checkForComputerWin() or @checkForBlockPlayerWin() or @checkForComputerDoubleThreat() or @checkForPlayerDoubleThreat() or @checkMiddleAvailability() or @checkPlayerOppositeCorner() or @getAnyCorner() or @getAnyWall()

  checkForComputerWin: ->
    @checkForPossibleWin(@board.secondPlayerToken)

  checkForBlockPlayerWin: ->
    @checkForPossibleWin(@board.firstPlayerToken)

  checkForComputerDoubleThreat: ->
    return true if @canGetCornerDoubleThreat()
    return true if @canGetWallDoubleThreat()
    false

  checkForPlayerDoubleThreat: ->
    return true if @checkCornerDoubleThreat(@board.firstPlayerToken) or @checkWallDoubleThreat(@board.firstPlayerToken)
    false

  checkMiddleAvailability: ->
    @getEmpty([4])

  checkPlayerOppositeCorner: ->
    @checkOppositeCorner(@board.firstPlayerToken)

  getAnyCorner: ->
    @getEmpty(@board.cornerSpots)

  getAnyWall: ->
    @getEmpty(@board.wallSpots)

  findEmpty: (spaces) ->
    @board.getSpaces(spaces, @board.emptyToken)

  getEmpty: (spaces) ->
    availableSpaces = @findEmpty(spaces)
    return @getBestMove(availableSpaces) if availableSpaces.length > 0
    false

  canGetWallDoubleThreat: ->
    return true if @checkWallDoubleThreat(@board.secondPlayerToken)
    false

  canGetCornerDoubleThreat: ->
    if @checkCornerDoubleThreat(@board.secondPlayerToken)
      for edge in @allEdges
        return @getBestMove([edge[1]]) if @checkAllEmpty(edge)
    false

  checkAllEmpty: (spots) ->
    @checkSpots(spots, @board.emptyToken)

  checkOppositeCorner: (token) ->
    filledSpaces = @board.getSpaces(@board.cornerSpots, token)
    @checkIfOppositeAvailable(filledSpaces)

  checkIfOppositeAvailable: (spaces) ->
    oppositeSpaces = @findOpposite(spaces)
    emptySpaces = @findEmpty(oppositeSpaces)
    return @getBestMove(emptySpaces) if emptySpaces.length > 0
    false

  findOpposite: (spaces) ->
    @board.oppositeSpots[space] for space in spaces

  checkWallDoubleThreat: (token) ->
   return true if @wallDoubleThreatPossible(token)
   false

  wallDoubleThreatPossible: (token) ->
    for combos in @wallCombos()
      return true if @occupyBothWalls(combos, token)

  occupyBothWalls: (combos, token) ->
    return @getBestMove(@intersection(combos[0], combos[1])) if @occupyWall(combos[0], token) and @occupyWall(combos[1], token)
    false

  intersection: (a, b) ->
    value for value in a when value in b

  occupyWall: (combo, token) ->
    @checkSpot(combo[1], token) and @findEmpty(combo).length is 2

  checkCornerDoubleThreat: (token) ->
    return @getBestMove(@board.wallSpots) if @cornerDoubleThreatPossible(token)
    false

  cornerDoubleThreatPossible: (token) ->
    return true if (@firstCornersOccupied(token) and @firstEdgesEmpty()) or (@secondCornerOccupied(token) and @secondEdgesEmpty())
    false

  firstCornersOccupied: (token) ->
    @checkSpots([0,8], token)

  secondCornerOccupied: (token) ->
    @checkSpots([2,6], token)

  firstEdgesEmpty: ->
    @checkEdgesEmpty([@allEdges[3],@allEdges[4]])

  secondEdgesEmpty: ->
    @checkEdgesEmpty([@allEdges[1],@allEdges[2]])

  checkEdgesEmpty: (edges) ->
    for edge in edges
      return true if @getEmpty(edge)
    false

  checkSpots: (locations, token) ->
    for spot in locations
      return false unless @checkSpot(spot, token)
    true

  checkSpot: (spot, token) ->
    @board.checkSpot(spot, token)

  checkForPossibleWin: (token) ->
    for winCombos in [@board.rows, @board.columns, @board.diagonals]
      for combo in winCombos
        return true if @winIsPossible(combo, token)
    false

  winIsPossible: (combo, token) ->
    return @getBestMove(combo) if @twoInARow(combo, token) and @isWinnable(combo)
    false

  getBestMove: (combo) ->
    @bestMove = @findEmpty(combo)[0]
    true

  twoInARow: (combo, token) ->
    @findAll(combo, token).length is 2

  findAll: (combo, token) ->
    @board.getSpaces(combo, token)

  isWinnable: (combo) ->
    @findEmpty(combo).length is 1

  allEdges: [[1,0,3],[5,8,7],[1,2,5],[3,6,7]]

  wallCombos: ->
    [[@board.rows[0],@board.columns[0]], [@board.rows[0],@board.columns[2]], [@board.rows[2],@board.columns[0]], [@board.rows[2],@board.columns[2]]]

window.Computer = Computer
