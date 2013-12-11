describe "Game", ->
  firstPlayer = secondPlayer = board = game = undefined
  beforeEach ->
    firstPlayer = new Player("firstPlayer")
    secondPlayer = new Player("secondPlayer") 
    board = new Board("X", "O")
    game = new Game(firstPlayer, secondPlayer, board)

  describe "Rules for a New Game", ->
    it "board should be blank when game starts", ->
      for position in game.board.spaces
       expect(position is " ").toBeTruthy()
    it "should default First Turn to firstPlayer", ->
      expect(game.turn).toEqual(firstPlayer)
    it "should allow secondPlayer to start first", ->
      newGame = new Game(firstPlayer, secondPlayer, board, secondPlayer)
      expect(newGame.turn).toEqual(secondPlayer)

  describe "Filling in Propper Token", ->
    beforeEach ->
      game.playerMove(1)
      game.playerMove(2)
    it "position should change to 'x' when first player selects a board location", ->
      expect(board.spaces[1]).toEqual("X")
    it "position should change to 'o' when second player selects a board location", ->
      expect(board.spaces[2]).toEqual("O")

  describe "Rules for alternating turns", ->
    it "turn should change to the secondPlayer after the firstPlayer plays", ->
      game.turn = firstPlayer
      game.playerMove(1)
      expect(game.turn).toEqual(secondPlayer)
    it "turn should change to the firstPlayer after the secondPlayer plays", ->
      game.turn = secondPlayer
      game.playerMove(1)
      expect(game.turn).toEqual(firstPlayer)
    it "turn should not change turn if an illegal move is played", ->
      game.turn = firstPlayer
      board.spaces[1] = "X"
      game.playerMove(1)
      expect(game.turn).toEqual(firstPlayer)
      game.turn = secondPlayer
      game.playerMove(1)
      expect(game.turn).toEqual(secondPlayer)

  describe "Rules for game is over", ->
    it "gameOver is false when the game starts", ->
      expect(game.gameOver).toEqual(false)

    it "gameOver is true if game is a draw and 'Nobody' is the winner", ->
      spyOn(board, 'checkForDraw').andReturn(true)
      game.checkGameOver()
      expect(game.gameOver).toEqual(true)
      expect(game.winner).toEqual('Nobody')

    it "gameOver is true when a player has won and 'X' or 'O' is the winner", ->
      spyOn(board, 'checkForWin').andReturn(true)
      game.checkGameOver()
      expect(game.gameOver).toEqual(true)
      expect(game.winner).toEqual('X')
