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
    
    it "should change position to 'x' when first player selects a board location", ->
      expect(game.checkLocation(1)).toEqual("X")

    it "should change position to 'o' when computer selects a board location", ->
      spyOn(game, 'computerLogic').andReturn(2)
      game.computerMove()
      expect(game.checkLocation(2)).toEqual("O")
