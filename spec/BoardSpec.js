// Generated by CoffeeScript 1.6.2
(function() {
  describe("Board", function() {
    var board, drawBoard, emptyBoard;

    emptyBoard = drawBoard = board = void 0;
    beforeEach(function() {
      emptyBoard = [" ", " ", " ", " ", " ", " ", " ", " ", " "];
      drawBoard = ["X", "O", "X", "O", "X", "O", "O", "X", "O"];
      return board = new Board("X", "O");
    });
    describe("new board", function() {
      return it("should initialize an empty board", function() {
        return expect(board.spaces).toEqual(emptyBoard);
      });
    });
    describe("checkSpot", function() {
      it("should return true if the parameter and the location match", function() {
        board.spaces = drawBoard;
        return expect(board.checkSpot(1, "O")).toEqual(true);
      });
      return it("should return false if the parameter and the location do not match", function() {
        return expect(board.checkSpot(1, "O")).toEqual(false);
      });
    });
    describe("getSpaces", function() {
      return it("should return an array of spaces that match the parameter give", function() {
        board.spaces = drawBoard;
        expect(board.getSpaces([0, 1, 2], "O")).toEqual([1]);
        return expect(board.getSpaces([0, 1, 2], "X")).toEqual([0, 2]);
      });
    });
    describe("checkForWinner", function() {
      it("should return the 'X' if the player has won without filling in the board", function() {
        board.spaces[0] = "X";
        board.spaces[4] = "X";
        board.spaces[8] = "X";
        return expect(board.checkForWinner()).toEqual("X");
      });
      it("should return the 'X' the player has won", function() {
        board.spaces = drawBoard;
        board.spaces[1] = "X";
        return expect(board.checkForWinner()).toEqual("X");
      });
      it("should return the 'O' if the player has won", function() {
        board.spaces = drawBoard;
        board.spaces[4] = "O";
        return expect(board.checkForWinner()).toEqual("O");
      });
      return it("should return false if the game if there is no winner", function() {
        board.spaces = emptyBoard;
        expect(board.checkForWinner()).toEqual(false);
        board.spaces = drawBoard;
        return expect(board.checkForWinner()).toEqual(false);
      });
    });
    describe("checkForDraw", function() {
      it("should return the true if the game is a draw", function() {
        board.spaces = drawBoard;
        return expect(board.checkForDraw()).toEqual(true);
      });
      it("should return false if there is still a playable move", function() {
        board.spaces = emptyBoard;
        return expect(board.checkForDraw()).toEqual(false);
      });
      return it("should return false if there is a winner", function() {
        board.spaces = drawBoard;
        board.spaces[4] = "O";
        return expect(board.checkForDraw()).toEqual(false);
      });
    });
    describe("firstPlayerMove", function() {
      it("should play the correct player token in the correct space if the space is blank", function() {
        board.firstPlayerMove(1);
        return expect(board.spaces[1]).toEqual("X");
      });
      return it("should return false if the spot is occupied", function() {
        board.spaces = drawBoard;
        return expect(board.firstPlayerMove(1)).toEqual(false);
      });
    });
    return describe("secondPlayerMove", function() {
      it("should play the correct computer token in the correct space if the space is blank", function() {
        board.secondPlayerMove(1);
        return expect(board.spaces[1]).toEqual("O");
      });
      return it("should return false if the spot is occumpied", function() {
        board.spaces = drawBoard;
        return expect(board.secondPlayerMove(1)).toEqual(false);
      });
    });
  });

}).call(this);
