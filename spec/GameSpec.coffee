describe "Game", ->
  computer = player = game = undefined
  beforeEach ->
    player = new Player
    game = new Game(player, computer)
  
  describe "New Game", ->
    it "board should be blank when game starts", ->
      for position in game.board
       expect(position is " ").toBeTruthy()
  
  describe "Taking a turn", ->
    
    beforeEach ->
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
