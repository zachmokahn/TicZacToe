class Computer
  gameLogic: (@board) ->
    return @winningLocation() if @canWin()
    return @blockLocation() if @canBlock()
    return @doubleThreatLocation() if @canDoubleThreat()
    return @blockDoubleThreatLocation() if @canBlockDoubleThreat()
    return @playCenterLocation() if @canPlayCenter()
    return @playOppositeCornerLocation() if @canPlayOppositeCorner()
    return @playAnyCornerLocation() if @willPlayAnyCorner()
    return @playWallLocation() if @willPlayWall()

  canWin: ->

  winningLocation: ->

  canBlock: ->

  blockLocation: ->

  canDoubleThreat: ->

  doubleThreatLocation: ->

  canBlockDoubleThreat: ->

  blockDoubleThreatLocation: ->

  canPlayCenter: ->

  playCenterLocation: ->

  canPlayOppositeCorner: ->

  playOppositeCornerLocation: ->

  willPlayAnyCorner: ->

  playAnyCornerLocation: ->

  willPlayWall: ->

  playWallLocation: ->

window.Computer = Computer
