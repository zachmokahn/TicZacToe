describe "AI methods", ->
  fullBoard = emptyBoard = ai = undefined
  beforeEach ->
    emptyBoard = [" "," "," "," "," "," "," "," "," "]
    fullBoard = ["X","X","X","X","X","X","X","X","X"]
    ai = new Computer("O","X")

  describe "#play Methods", ->

    describe "WallLocation", ->
      beforeEach ->
        spyOn(ai, 'winningLocation').andReturn(null)
        spyOn(ai, 'blockLocation').andReturn(null)
        spyOn(ai, 'blockDoubleThreatLocation').andReturn(null)
        spyOn(ai, 'playCenterLocation').andReturn(null)
        spyOn(ai, 'playOppositeCornerLocation').andReturn(null)
        spyOn(ai, 'playAnyCornerLocation').andReturn(null)
      it "should return an array of all the wall spots if the board is empty", ->
        expect(ai.gameLogic(emptyBoard)).toEqual([1,3,5,7])
      it "should return an array of approriate characters", ->
        emptyBoard[1] = "X"
        expect(ai.gameLogic(emptyBoard)).toEqual([3,5,7])
        emptyBoard[7] = "X"
        expect(ai.gameLogic(emptyBoard)).toEqual([3,5])

    describe "CornerLocation", ->
      beforeEach ->
        spyOn(ai, 'winningLocation').andReturn(null)
        spyOn(ai, 'blockLocation').andReturn(null)
        spyOn(ai, 'blockDoubleThreatLocation').andReturn(null)
        spyOn(ai, 'playCenterLocation').andReturn(null)
        spyOn(ai, 'playOppositeCornerLocation').andReturn(null)
      it "should return an array of all the corner spots if the board is empty", ->
        expect(ai.gameLogic(emptyBoard)).toEqual([0,2,6,8])
      it " should return an array of approriate characters", ->
        emptyBoard[0] = "X"
        expect(ai.gameLogic(emptyBoard)).toEqual([2,6,8])
        emptyBoard[8] = "X"
        expect(ai.gameLogic(emptyBoard)).toEqual([2,6])

    describe "OppositeCornerLocation", ->
      beforeEach ->
        spyOn(ai, 'winningLocation').andReturn(null)
        spyOn(ai, 'blockLocation').andReturn(null)
        spyOn(ai, 'blockDoubleThreatLocation').andReturn(null)
        spyOn(ai, 'playCenterLocation').andReturn(null)
      it "should return [0] if [8] is occupied", ->
        emptyBoard[8] = "X"
        expect(ai.gameLogic(emptyBoard)).toEqual([0])
      it "should return [2] if [6] is occupied", ->
        emptyBoard[6] = "X"
        expect(ai.gameLogic(emptyBoard)).toEqual([2])

    describe "CenterLocation", ->
      beforeEach ->
        spyOn(ai, 'winningLocation').andReturn(null)
        spyOn(ai, 'blockLocation').andReturn(null)
        spyOn(ai, 'blockDoubleThreatLocation').andReturn(null)
      it "should return [4] if center is unoccupied", ->
        expect(ai.gameLogic(emptyBoard)).toEqual([4])

    describe "blockDoubleThreat", ->
      beforeEach ->
        spyOn(ai, 'winningLocation').andReturn(null)
        spyOn(ai, 'blockLocation').andReturn(null)
      it "should return [1,3,5,7] if [2,6] are occupied by the player", ->
        emptyBoard[2] = "X"
        emptyBoard[6] = "X"
        expect(ai.gameLogic(emptyBoard)).toEqual([1,3,5,7])

    describe "Check For Wins", ->

      describe "Check Horizontal Win", ->
        it "should return [2] if [0,1] are occupied", ->
          emptyBoard[0] = "X"
          emptyBoard[1] = "X"
          ai.board = emptyBoard
          expect(ai.check("X", ai.rows)).toEqual([2])
        it "should return [0] if [1,2] are occupied", ->
          emptyBoard[1] = "X"
          emptyBoard[2] = "X"
          ai.board = emptyBoard
          expect(ai.check("X", ai.rows)).toEqual([0])
        it "should return [4] if [3,5] are occupied", ->
          emptyBoard[3] = "X"
          emptyBoard[5] = "X"
          ai.board = emptyBoard
          expect(ai.check("X", ai.rows)).toEqual([4])
        it "should return undefined if [6,7,8] are occupied", ->
          emptyBoard[6] = "X"
          emptyBoard[7] = "X"
          emptyBoard[8] = "O"
          ai.board = emptyBoard
          expect(ai.check("X", ai.rows)).toEqual(null)

      describe "Check Vertical Win", ->
        it "should return [4] if [1,7] are occupied", ->
          emptyBoard[1] = "X"
          emptyBoard[7] = "X"
          ai.board = emptyBoard
          expect(ai.check("X", ai.columns)).toEqual([4])
        it "should return [1] if [4,7] are occupied", ->
          emptyBoard[4] = "X"
          emptyBoard[7] = "X"
          ai.board = emptyBoard
          expect(ai.check("X", ai.columns)).toEqual([1])
        it "should return [8] if [2,5] are occupied", ->
          emptyBoard[2] = "X"
          emptyBoard[5] = "X"
          ai.board = emptyBoard
          expect(ai.check("X", ai.columns)).toEqual([8])
        it "should return undefined if [0,3,6] are occupied", ->
          emptyBoard[0] = "X"
          emptyBoard[3] = "X"
          emptyBoard[6] = "O"
          ai.board = emptyBoard
          expect(ai.check("X", ai.columns)).toEqual(null)

      describe "Check Diagonal Win", ->
        it "should return [4] if [0,8] are occupied", ->
          emptyBoard[0] = "X"
          emptyBoard[8] = "X"
          ai.board = emptyBoard
          expect(ai.check("X", ai.diagonals)).toEqual([4])
        it "should return [2] if [4,6] are occupied", ->
          emptyBoard[4] = "X"
          emptyBoard[6] = "X"
          ai.board = emptyBoard
          expect(ai.check("X", ai.diagonals)).toEqual([2])
        it "should return undefined if [0,4,8] are occupied", ->
          emptyBoard[0] = "X"
          emptyBoard[4] = "X"
          emptyBoard[8] = "O"
          ai.board = emptyBoard
          expect(ai.check("X", ai.diagonals)).toEqual(null)

    describe "blockLocation", ->
      beforeEach ->
        console.log("HERE")
        spyOn(ai, 'winningLocation').andReturn(null)
      it "HORIZONTAL CHECK: it should return [1] if [0,2] are occupied by opponent", ->
        emptyBoard[0] = "X"
        emptyBoard[2] = "X"
        expect(ai.gameLogic(emptyBoard)).toEqual([1])
      it "VERTICAL CHECK: it should return [7] if [1,4] are occupied by opponent", ->
        emptyBoard[1] = "X"
        emptyBoard[4] = "X"
        expect(ai.gameLogic(emptyBoard)).toEqual([7])
      it "DIAGONAL CHECK: it should return [0] if [4,8] are occupied by opponent", ->
        emptyBoard[4] = "X"
        emptyBoard[8] = "X"
        expect(ai.gameLogic(emptyBoard)).toEqual([0])
