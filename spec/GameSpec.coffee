describe "Game", ->
  player = game = undefined
  beforeEach ->
    player = new Player
    game = new Game(player)
  
  describe "New Game", ->
    it "board should be blank when game starts", ->
      for position in game.board
       expect(position is " ").toBeTruthy()
