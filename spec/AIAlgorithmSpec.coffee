describe "AI algorithm", ->
  ai = undefined
  beforeEach ->
    ai = new Computer
    spyOn(ai, 'canWin').andReturn(false)
    spyOn(ai, 'canBlock').andReturn(false)
    spyOn(ai, 'canDoubleThreat').andReturn(false)
    spyOn(ai, 'canBlockDoubleThreat').andReturn(false)
    spyOn(ai, 'canPlayCenter').andReturn(false)
    spyOn(ai, 'canPlayOppositeCorner').andReturn(false)
    spyOn(ai, 'willPlayAnyCorner').andReturn(false)
    spyOn(ai, 'willPlayWall').andReturn(true)
    spyOn(ai, 'playWallLocation')

  it "plays the winning move if it can win", ->
    ai.canWin.andReturn(true)
    spyOn(ai, 'winningLocation')
    ai.gameLogic()
    expect(ai.winningLocation).toHaveBeenCalled()

  it "blocks the player if a winning move cannot be played", ->
    ai.canBlock.andReturn(true)
    spyOn(ai, 'blockLocation')
    ai.gameLogic()
    expect(ai.blockLocation).toHaveBeenCalled()

  it "creates a double threat if the player has nothing to be blocked", ->
    ai.canDoubleThreat.andReturn(true)
    spyOn(ai, 'doubleThreatLocation')
    ai.gameLogic()
    expect(ai.doubleThreatLocation).toHaveBeenCalled()

  it "blocks a double threat opportunity if the computer cannot create a double threat", ->
    ai.canBlockDoubleThreat.andReturn(true)
    spyOn(ai, 'blockDoubleThreatLocation')
    ai.gameLogic()
    expect(ai.blockDoubleThreatLocation).toHaveBeenCalled()

  it "plays the center space if there is no threat of double threat", ->
    ai.canPlayCenter.andReturn(true)
    spyOn(ai, 'playCenterLocation')
    ai.gameLogic()
    expect(ai.playCenterLocation).toHaveBeenCalled()

  it "plays the opposite corner from the player if the center is taken", ->
    ai.canPlayOppositeCorner.andReturn(true)
    spyOn(ai, 'playOppositeCornerLocation')
    ai.gameLogic()
    expect(ai.playOppositeCornerLocation).toHaveBeenCalled()

  it "plays any corner if the player has not take a corner", ->
    ai.willPlayAnyCorner.andReturn(true)
    spyOn(ai, 'playAnyCornerLocation')
    ai.gameLogic()
    expect(ai.playAnyCornerLocation).toHaveBeenCalled()


  it "plays a wall spot if no corners are available", ->
    ai.gameLogic()
    expect(ai.playWallLocation).toHaveBeenCalled()
