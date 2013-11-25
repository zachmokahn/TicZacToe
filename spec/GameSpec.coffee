describe "Game", ->
  player = game = undefined
  beforeEach ->
    player = new Player
    game = new Game(player)
  
  describe "New Game", ->
    it "board should be blank when game starts", ->
      for position in game.board
       expect(position is " ").toBeTruthy()
  
  describe "Taking a turn", ->
    game = undefined
    beforeEach ->
      game = new Game(player)
      game.playerMove(1)
      spyOn(game, 'computerLogic').andReturn(2)
      game.computerMove()
    
    it "position should change to 'x' when first player selects a board location", ->
      expect(game.checkLocation(1)).toEqual("X")

    it "position should change to 'o' when computer selects a board location", ->
      expect(game.checkLocation(2)).toEqual("O")

    it "position should not change if it is already filled on the board", ->
      game.playerMove(2)
      expect(game.checkLocation(2)).toEqual("O")
      game.computerLogic.andReturn(1)
      game.computerMove()
      expect(game.checkLocation(1)).toEqual("X")
    
  describe "alternating turns", ->
    game = undefined
    beforeEach ->
      game = new Game(player)

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

    it "turn should not change if the 'user' makes an illegal move", ->
      game.playerMove(1)
      spyOn(game, 'computerLogic').andReturn(2)
      game.computerMove()
      game.playerMove(2)
      expect(game.turn).toEqual("player")
