describe "Board", ->
  emptyBoard = drawBoard = board = undefined
  beforeEach ->
    emptyBoard = [" "," "," "," "," "," "," "," "," "]
    drawBoard  = ["X", "O", "X", "O", "X", "O", "O", "X", "O"]
    board = new Board("X", "O")

  describe "new board", ->
    it "should initialize an empty board", ->
      expect(board.spaces).toEqual(emptyBoard)

  describe "checkSpot", ->
    it "should return true if the parameter and the location match", ->
      board.spaces = drawBoard
      expect(board.checkSpot(1, "O")).toEqual(true)
    it "should return false if the parameter and the location do not match", ->
      expect(board.checkSpot(1, "O")).toEqual(false)

  describe "getSpaces", ->
    it "should return an array of spaces that match the parameter give", ->
      board.spaces = drawBoard
      expect(board.getSpaces([0,1,2], "O")).toEqual([1])
      expect(board.getSpaces([0,1,2], "X")).toEqual([0,2])

  describe "checkForWinner", ->
    it "should return the 'X' the player has won", ->
      board.spaces = drawBoard
      board.spaces[1] = "X"
      expect(board.checkForWinner()).toEqual("X")

    it "should return the 'O' if the player has won", ->
      board.spaces = drawBoard
      board.spaces[4] = "O"
      expect(board.checkForWinner()).toEqual("O")

    it "should return false if the game if there is no winner", ->
      board.spaces = emptyBoard
      expect(board.checkForWinner()).toEqual(false)
      board.spaces = drawBoard
      expect(board.checkForWinner()).toEqual(false)

  describe "checkForDraw", ->
    it "should return the true if the game is a draw", ->
      board.spaces = drawBoard
      expect(board.checkForDraw()).toEqual(true)

    it "should return false if there is still a playable move", ->
      board.spaces = emptyBoard
      expect(board.checkForDraw()).toEqual(false)

    it "should return false if there is a winner", ->
      board.spaces = drawBoard
      board.spaces[4] = "O"
      expect(board.checkForDraw()).toEqual(false)

  describe "firstPlayerMove", ->
    it "should play the correct player token in the correct space if the space is blank", ->
      board.firstPlayerMove(1)
      expect(board.spaces[1]).toEqual("X")

    it "should return false if the spot is occupied", ->
      board.spaces = drawBoard
      expect(board.firstPlayerMove(1)).toEqual(false)

  describe "secondPlayerMove", ->
    it "should play the correct computer token in the correct space if the space is blank", ->
      board.secondPlayerMove(1)
      expect(board.spaces[1]).toEqual("O")

    it "should return false if the spot is occumpied", ->
     board.spaces = drawBoard
     expect(board.secondPlayerMove(1)).toEqual(false)
