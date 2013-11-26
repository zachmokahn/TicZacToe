describe "AI", ->
  describe "algorithm flow", ->
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
  
  describe "Computer Logic", ->
    game = undefined
    beforeEach ->
      game = new Game(new Player("test"))
    it "should take the winning move if present", ->
      game.board[0] = "X"
      game.board[1] = "O"
      game.board[2] = "X"
      game.board[4] = "O"
      game.board[3] = "X"
      expect(game.computerLogic()).toEqual(7)

    it "should take the blocking move if present and can't win", ->
      game.board[0] = "X"
      game.board[4] = "O"
      game.board[3] = "X"
      expect(game.computerLogic()).toEqual(6)

    it "should take a wall if double threat present", ->
      game.board[0] = "X"
      game.board[4] = "O"
      game.board[8] = "X"
      expect(game.computerLogic()).toEqual(1)

    it "should take the center if not taken on first move", ->
      game.playerMove(1)
      expect(game.computerLogic()).toEqual(4)

    it "should take an opposite corner if no center is availabe", ->
      game.board[0] = "X"
      game.board[4] = "O"
      game.board[5] = "X"
      expect(game.computerLogic()).toEqual(8)

    it "should play any corner", ->
      game.board[3] = "X"
      game.board[4] = "O"
      game.board[5] = "X"
      expect(game.computerLogic()).toEqual(0)

    it "should play any wall if it can't play any corner", ->
      game.board[4] = "X"
      game.board[0] = "O"
      game.board[8] = "X"
      game.board[6] = "O"
      game.board[2] = "X"
      game.board[5] = "O"
      game.board[3] = "X"
      expect(game.computerLogic()).toEqual(1)
