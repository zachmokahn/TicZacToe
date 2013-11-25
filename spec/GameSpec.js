// Generated by CoffeeScript 1.6.2
(function() {
  describe("Game", function() {
    var game, player;

    player = game = void 0;
    beforeEach(function() {
      player = new Player("test");
      return game = new Game(player);
    });
    describe("Rules for a New Game", function() {
      return it("board should be blank when game starts", function() {
        var position, _i, _len, _ref, _results;

        _ref = game.board;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          position = _ref[_i];
          _results.push(expect(position === " ").toBeTruthy());
        }
        return _results;
      });
    });
    describe("Rules for taking a turn", function() {
      beforeEach(function() {
        game.playerMove(1);
        spyOn(game, 'computerLogic').andReturn(2);
        return game.computerMove();
      });
      it("position should change to 'x' when first player selects a board location", function() {
        return expect(game.checkLocation(1)).toEqual("X");
      });
      it("position should change to 'o' when computer selects a board location", function() {
        return expect(game.checkLocation(2)).toEqual("O");
      });
      return it("position should not change and error should be raised if it is already filled on the board", function() {
        spyOn(game, 'illegalTurnError');
        game.playerMove(2);
        expect(game.checkLocation(2)).toEqual("O");
        game.computerMove();
        expect(game.checkLocation(1)).toEqual("X");
        return expect(game.illegalTurnError.calls.length).toEqual(2);
      });
    });
    describe("Rules fo alternating turns", function() {
      it("turn should initialize to the player", function() {
        return expect(game.turn).toEqual("player");
      });
      it("turn should change to the computer after the 'user' plays", function() {
        game.playerMove(1);
        return expect(game.turn).toEqual("computer");
      });
      it("turn should change to the 'users' after the computer plays", function() {
        game.playerMove(1);
        spyOn(game, 'computerLogic').andReturn(2);
        game.computerMove();
        return expect(game.turn).toEqual("player");
      });
      it("turn should not change and error should be raised if the 'user' makes an illegal move", function() {
        spyOn(game, 'illegalTurnError');
        spyOn(game, 'computerLogic').andReturn(2);
        game.playerMove(1);
        game.computerMove();
        game.playerMove(2);
        expect(game.turn).toEqual("player");
        return expect(game.illegalTurnError).toHaveBeenCalled();
      });
      it("should raise an error and not allow the player to choose unless it is the player's turn", function() {
        game.turn = "computer";
        spyOn(game, 'illegalTurnError');
        game.playerMove(1);
        return expect(game.illegalTurnError).toHaveBeenCalled();
      });
      return it("should raise and error and not allow the computer to choose unless it is the computer's turn", function() {
        spyOn(game, 'illegalTurnError');
        spyOn(game, 'computerLogic').andReturn(2);
        game.computerMove();
        return expect(game.illegalTurnError).toHaveBeenCalled();
      });
    });
    return describe("Rules for game is over", function() {
      it("gameOver is false when the game starts", function() {
        return expect(game.gameOver).toEqual(false);
      });
      it("gameOver is true and alert is sent when the Player has won", function() {
        spyOn(game, 'playerWin').andReturn(true);
        spyOn(game, 'playerWon');
        game.checkStatus();
        expect(game.gameOver).toEqual(true);
        return expect(game.playerWon).toHaveBeenCalled();
      });
      it("gameOver is true and alert is sent when the Computer has won", function() {
        spyOn(game, 'computerWin').andReturn(true);
        spyOn(game, 'computerWon');
        game.checkStatus();
        expect(game.gameOver).toEqual(true);
        return expect(game.computerWon).toHaveBeenCalled();
      });
      it("gameOver is true and alert is sent when the game is a draw", function() {
        spyOn(game, 'isDraw').andReturn(true);
        spyOn(game, 'nobodyWon');
        game.checkStatus();
        expect(game.gameOver).toEqual(true);
        return expect(game.nobodyWon).toHaveBeenCalled();
      });
      it("Player is not allowed to move if the game is over", function() {
        spyOn(game, 'gameOverError');
        game.gameOver = true;
        game.playerMove(1);
        return expect(game.gameOverError).toHaveBeenCalled();
      });
      return it("Computer is not allowed to move if the game is over", function() {
        spyOn(game, 'gameOverError');
        game.playerMove(1);
        game.gameOver = true;
        game.computerMove();
        return expect(game.gameOverError).toHaveBeenCalled();
      });
    });
  });

}).call(this);
