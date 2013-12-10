describe "Computer", ->
  modifiedBoard = board = computer = undefined
  beforeEach ->
    modifiedBoard = [" "," "," "," "," "," "," "," "," "]
    board = new Board("X", "O")
    computer = new Computer(board)
  describe "new Computer", ->
    it "should take a Board in the parameters", ->
      expect(computer.board).toEqual(board)
    it "should detect the spaces in the board", ->
      expect(computer.readSpaces()).toEqual(modifiedBoard)

  describe "Methods", ->
    describe "checkForComputerWin", ->
      it "should return true and assign bestMove to the winning move", ->
        modifiedBoard[0] = "O"
        modifiedBoard[1] = "O"
        board.spaces = modifiedBoard
        expect(computer.checkForComputerWin()).toEqual(true)
        expect(computer.bestMove).toEqual(2)

      it "should return false and not assign bestMove if win is not present", ->
        modifiedBoard[0] = "O"
        modifiedBoard[1] = "X"
        board.spaces = modifiedBoard
        expect(computer.checkForComputerWin()).toEqual(false)
        expect(computer.bestMove).not.toBeDefined()

    describe "checkForBlockPlayerWin", ->
      it "should return true and assign bestMove to the blocking move", ->
        modifiedBoard[0] = "X"
        modifiedBoard[1] = "X"
        board.spaces = modifiedBoard
        expect(computer.checkForBlockPlayerWin()).toEqual(true)
        expect(computer.bestMove).toEqual(2)

      it "should return false and not assign bestMove if block is not present", ->
        modifiedBoard[0] = "O"
        modifiedBoard[1] = "X"
        board.spaces = modifiedBoard
        expect(computer.checkForBlockPlayerWin()).toEqual(false)
        expect(computer.bestMove).not.toBeDefined()

    describe "checkForPlayerDoubleThreat", ->
      describe "checkCornerDoubleThreat", ->
        it "should return true and assign bestMove to a doubleThreat deterent if [0,8] filled", ->
          modifiedBoard[0] = "X"
          modifiedBoard[4] = "O"
          modifiedBoard[8] = "X"
          board.spaces = modifiedBoard
          expect(computer.checkForPlayerDoubleThreat()).toEqual(true)
          expect(computer.bestMove).toEqual(1)

        it "should return true and assign bestMove to a doubleThreat deterent if [2,6] filled", ->
          modifiedBoard[2] = "X"
          modifiedBoard[4] = "O"
          modifiedBoard[6] = "X"
          board.spaces = modifiedBoard
          expect(computer.checkForPlayerDoubleThreat()).toEqual(true)
          expect(computer.bestMove).toEqual(1)
        it "should return false and not assign bestMove if cornerDoubleThreat is not present", ->
          board.spaces = modifiedBoard
          expect(computer.checkForPlayerDoubleThreat()).toEqual(false)
          expect(computer.bestMove).not.toBeDefined()

      describe "checkWallDoubleThreat", ->
        it "should return true and assign bestMove to a doubleThreat deterent if [5,7] filled", ->
          modifiedBoard[5] = "X"
          modifiedBoard[4] = "O"
          modifiedBoard[7] = "X"
          board.spaces = modifiedBoard
          expect(computer.checkForPlayerDoubleThreat()).toEqual(true)
          expect(computer.bestMove).toEqual(8)

        it "should return true and assign bestMove to a doubleThreat deterent if [3,7] filled", ->
          modifiedBoard[3] = "X"
          modifiedBoard[4] = "O"
          modifiedBoard[7] = "X"
          board.spaces = modifiedBoard
          expect(computer.checkForPlayerDoubleThreat()).toEqual(true)
          expect(computer.bestMove).toEqual(6)

        it "should return false and not assign bestMove if a wallDoubleThreat is not present", ->
          board.spaces = modifiedBoard
          expect(computer.checkForPlayerDoubleThreat()).toEqual(false)
          expect(computer.bestMove).not.toBeDefined()

     describe "checkMiddleAvailability", ->
        it "should return true and assign bestMove to the middle if space [4] is available", ->
          board.spaces = modifiedBoard
          expect(computer.checkMiddleAvailability()).toEqual(true)
          expect(computer.bestMove).toEqual(4)

        it "should return false and not assign besetMove if the middle is not available", ->
          modifiedBoard[4] = "X"
          board.spaces = modifiedBoard
          expect(computer.checkMiddleAvailability()).toEqual(false)
          expect(computer.bestMove).not.toBeDefined()

      describe "checkOppositeCorner", ->
        it "should return true and assign bestMove to the opposite corner if available", ->
          modifiedBoard[0] = "X"
          modifiedBoard[4] = "O"
          modifiedBoard[5] = "X"
          board.spaces = modifiedBoard
          expect(computer.checkPlayerOppositeCorner()).toEqual(true)
          expect(computer.bestMove).toEqual(8)

        it "should return false and not assign bestMove if both corners are occupied", ->
          modifiedBoard[0] = "X"
          modifiedBoard[8] = "O"
          board.spaces = modifiedBoard
          expect(computer.checkPlayerOppositeCorner()).toEqual(false)
          expect(computer.bestMove).not.toBeDefined()

        it "should return false and not assign bestMove if no corners are occupied", ->
          board.spaces = modifiedBoard
          expect(computer.checkPlayerOppositeCorner()).toEqual(false)
          expect(computer.bestMove).not.toBeDefined()

      describe "getAnyCorner", ->
        it "should return true and assign bestMove to any corner if availaible", ->
          board.spaces = modifiedBoard
          expect(computer.getAnyCorner()).toEqual(true)
          expect(computer.bestMove).toEqual(0)

        it "should return false and not assign bestMove if no corner is available", ->
          modifiedBoard[0] = "X"
          modifiedBoard[6] = "X"
          modifiedBoard[2] = "O"
          modifiedBoard[8] = "O"
          board.spaces = modifiedBoard
          expect(computer.getAnyCorner()).toEqual(false)
          expect(computer.bestMove).not.toBeDefined()

     describe "getAnyWall", ->
       it "should return true and assign bestMove to any wall spot if available", ->
         board.spaces = modifiedBoard
         expect(computer.getAnyWall()).toEqual(true)
         expect(computer.bestMove).toEqual(1)

       it "should return false and not assign bestMove if no wall is available", ->
          modifiedBoard[1] = "X"
          modifiedBoard[3] = "X"
          modifiedBoard[5] = "O"
          modifiedBoard[7] = "O"
          board.spaces = modifiedBoard
          expect(computer.getAnyWall()).toEqual(false)
          expect(computer.bestMove).not.toBeDefined()

  describe "findBestMove", ->
    it "should take the winning move if present", ->
      computer.board.spaces[0] = "X"
      computer.board.spaces[1] = "O"
      computer.board.spaces[2] = "X"
      computer.board.spaces[4] = "O"
      computer.board.spaces[3] = "X"
      expect(computer.findBestMove()).toEqual(7)

    it "should take the blocking move if present and can't win", ->
      computer.board.spaces[0] = "X"
      computer.board.spaces[4] = "O"
      computer.board.spaces[3] = "X"
      expect(computer.findBestMove()).toEqual(6)

    it "should take a wall if corner double threat is present and no block is available", ->
      computer.board.spaces[0] = "X"
      computer.board.spaces[4] = "O"
      computer.board.spaces[8] = "X"
      expect(computer.findBestMove()).toEqual(1)

    it "should take the blocking corner if a wall double threat present and no block is available", ->
      computer.board.spaces[5] = "X"
      computer.board.spaces[4] = "O"
      computer.board.spaces[7] = "X"
      expect(computer.findBestMove()).toEqual(8)

    it "should take the center if no double threat present", ->
      expect(computer.findBestMove()).toEqual(4)

    it "should take an opposite corner if no center is available", ->
      computer.board.spaces[0] = "X"
      computer.board.spaces[4] = "O"
      computer.board.spaces[5] = "X"
      expect(computer.findBestMove()).toEqual(8)

    it "should play any corner if no opposite corner is available", ->
      computer.board.spaces[3] = "X"
      computer.board.spaces[4] = "O"
      computer.board.spaces[5] = "X"
      expect(computer.findBestMove()).toEqual(0)

    it "should play any wall if it no corner is available", ->
      computer.board.spaces[4] = "X"
      computer.board.spaces[0] = "O"
      computer.board.spaces[8] = "X"
      computer.board.spaces[6] = "O"
      computer.board.spaces[2] = "X"
      computer.board.spaces[5] = "O"
      computer.board.spaces[3] = "X"
      expect(computer.findBestMove()).toEqual(1)
