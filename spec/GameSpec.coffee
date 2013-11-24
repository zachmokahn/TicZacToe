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
    it "should change position to 'x' when first player selects a board location", ->
      game.playerMove(1)
      expect(game.checkLocation(1)).toEqual("X")
