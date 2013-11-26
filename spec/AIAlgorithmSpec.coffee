describe "AI algorithm", ->
  ai = undefined
  beforeEach ->
    ai = new Computer
    spyOn(ai, 'winningLocation').andReturn(false)
    spyOn(ai, 'blockLocation').andReturn(false)
    spyOn(ai, 'blockDoubleThreatLocation').andReturn(false)
    spyOn(ai, 'playCenterLocation').andReturn(false)
    spyOn(ai, 'playOppositeCornerLocation').andReturn(false)
    spyOn(ai, 'playAnyCornerLocation').andReturn(false)
    spyOn(ai, 'playWallLocation').andReturn(false)
  it "plays the winning move if it can win", ->
    ai.winningLocation.andReturn(true)
    ai.gameLogic()
    expect(ai.winningLocation).toHaveBeenCalled()
  it "blocks the player if a winning move cannot be played", ->
    ai.blockLocation.andReturn(true)
    ai.gameLogic()
    expect(ai.blockLocation).toHaveBeenCalled()
  it "blocks a double threat opportunity if the computer cannot create a double threat", ->
    ai.blockDoubleThreatLocation.andReturn(true)
    ai.gameLogic()
    expect(ai.blockDoubleThreatLocation).toHaveBeenCalled()
  it "plays the center space if there is no threat of double threat", ->
    ai.playCenterLocation.andReturn(true)
    ai.gameLogic()
    expect(ai.playCenterLocation).toHaveBeenCalled()
  it "plays the opposite corner from the player if the center is taken", ->
    ai.playOppositeCornerLocation.andReturn(true)
    ai.gameLogic()
    expect(ai.playOppositeCornerLocation).toHaveBeenCalled()
  it "plays any corner if the player has not take a corner", ->
    ai.playAnyCornerLocation.andReturn(true)
    ai.gameLogic()
    expect(ai.playAnyCornerLocation).toHaveBeenCalled()
  it "plays a wall spot if no corners are available", ->
    ai.gameLogic()
    expect(ai.playWallLocation).toHaveBeenCalled()
