describe "Game", ->
  player = game = undefined
  beforeEach ->
    player = new Player
    game = new Game(player)

  describe "Rules for a New Game", ->
    it "board should be blank when game starts", ->
      for position in game.board
       expect(position is " ").toBeTruthy()

  describe "Rules for taking a turn", ->
    beforeEach ->
      game.playerMove(1)
      spyOn(game, 'computerLogic').andReturn(2)
      game.computerMove()

    it "position should change to 'x' when first player selects a board location", ->
      expect(game.checkLocation(1)).toEqual("X")

    it "position should change to 'o' when computer selects a board location", ->
      expect(game.checkLocation(2)).toEqual("O")

    it "position should not change and error should be raised if it is already filled on the board", ->
      spyOn(game, 'illegalTurnError')
      game.playerMove(2)
      expect(game.checkLocation(2)).toEqual("O")
      game.computerMove()
      expect(game.checkLocation(1)).toEqual("X")
      expect(game.illegalTurnError.calls.length).toEqual(2)

  describe "Rules fo alternating turns", ->

    it "turn should initialize to the player", -> 
      expect(game.turn).toEqual("player")

    it "turn should change to the computer after the 'user' plays", ->
      game.playerMove(1)
      expect(game.turn).toEqual("computer")

    it "turn should change to the 'users' after the computer plays", ->
      game.playerMove(1)
      spyOn(game, 'computerLogic').andReturn(2)
      game.computerMove()
      expect(game.turn).toEqual("player")

    it "turn should not change and error should be raised if the 'user' makes an illegal move", ->
      spyOn(game, 'illegalTurnError')
      spyOn(game, 'computerLogic').andReturn(2)
      game.playerMove(1)
      game.computerMove()
      game.playerMove(2)
      expect(game.turn).toEqual("player")
      expect(game.illegalTurnError).toHaveBeenCalled()

    it "should raise an error and not allow the player to choose unless it is the player's turn", ->
      game.turn = "computer"
      spyOn(game, 'illegalTurnError')
      game.playerMove(1)
      expect(game.illegalTurnError).toHaveBeenCalled()

    it "should raise and error and not allow the computer to choose unless it is the computer's turn", ->
      spyOn(game, 'illegalTurnError')
      spyOn(game, 'computerLogic').andReturn(2)
      game.computerMove()
      expect(game.illegalTurnError).toHaveBeenCalled()

  describe "Rules for game is over", ->
    it "gameOver is false when the game starts", ->
      expect(game.gameOver).toEqual(false)

    it "gameOver is true when the Player has won", ->
      spyOn(game, 'playerWin').andReturn(true)
      game.checkStatus()
      expect(game.gameOver).toEqual(true)

    it "gameOver is true when the Computer has won", ->
      spyOn(game, 'computerWin').andReturn(true)
      game.checkStatus()
      expect(game.gameOver).toEqual(true)

    it "gameOver is true when the game is a draw", ->
      spyOn(game, 'isDraw').andReturn(true)
      game.checkStatus()
      expect(game.gameOver).toEqual(true)

    it "should not allow the player to move if the game is over", ->
      spyOn(game, 'gameOverError')
      game.gameOver = true
      game.playerMove(1)
      expect(game.gameOverError).toHaveBeenCalled()

    it "should not allow the computer to move if the game is over", ->
      spyOn(game, 'gameOverError')
      game.playerMove(1)
      game.gameOver = true
      game.computerMove()
      expect(game.gameOverError).toHaveBeenCalled()

