describe "Game", ->
  player = game = undefined
  beforeEach ->
    player = new Player("test")
    game = new Game(player)

  describe "Rules for a New Game", ->
    it "board should be blank when game starts", ->
      for position in game.board
       expect(position is " ").toBeTruthy()
    it "should default Player's symbol to 'X", ->
      expect(game.playerToken).toEqual("X")
    it "should default Computer's symbol to 'O'", ->
      expect(game.computerToken).toEqual("O")
    it "should default First Turn to 'player'", ->
      expect(game.turn).toEqual("player")
    it "should allow player and computer symbols to be swapped", ->
      newGame = new Game(player, "player", "O")
      expect(newGame.playerToken).toEqual("O")
      expect(newGame.computerToken).toEqual("X")
    it "should all computer to have the first turn", ->
      newGame = new Game(player, "computer")
      expect(newGame.turn).toEqual("computer")

  describe "Rules for taking a turn", ->
    beforeEach ->
      game.playerMove(1)
      spyOn(game, 'computerLogic').andReturn(2)
      game.computerMove()
    it "position should change to 'x' when first player selects a board location", ->
      expect(game.checkLocation(1)).toEqual("X")
    it "position should change to 'o' when computer selects a board location", ->
      expect(game.checkLocation(2)).toEqual("O")

  describe "Computer Logic", ->
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

  describe "Rules for alternating turns", ->
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
    it "turn should not change turn if the 'user' makes an illegal move", ->
      spyOn(game, 'computerLogic').andReturn(2)
      game.playerMove(1)
      game.computerMove()
      game.playerMove(2)
      expect(game.turn).toEqual("player")

  describe "Rules for game is over", ->
    it "gameOver is false when the game starts", ->
      expect(game.gameOver).toEqual(false)
    it "gameOver is true and alert is sent when the Player has won", ->
      spyOn(game, 'checkIfWon').andReturn(true)
      spyOn(game, 'playerWon')
      game.playerMove(1)
      expect(game.gameOver).toEqual(true)
      expect(game.playerWon).toHaveBeenCalled()
    it "gameOver is true and alert is sent when the Computer has won", ->
      game.turn = "computer"
      spyOn(game, 'checkIfWon').andReturn(true)
      spyOn(game, 'computerWon')
      game.computerMove()
      expect(game.gameOver).toEqual(true)
      expect(game.computerWon).toHaveBeenCalled()
    it "gameOver is true and alert is sent when the game is a draw", ->
      spyOn(game, 'nobodyWon')
      game.moveCount = 8
      game.playerMove(4)
      expect(game.gameOver).toEqual(true)
      expect(game.nobodyWon).toHaveBeenCalled()
    it "gameIsWon Should return True if 0,1,2 are filled with 'X'", ->
      game.board[0] = "X"
      game.board[1] = "X"
      game.board[2] = "X"
      expect(game.checkIfWon("X")).toEqual(true)
