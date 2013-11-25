// Generated by CoffeeScript 1.6.2
(function() {
  var Game;

  Game = (function() {
    function Game(player) {
      this.player = player;
      this.board = [" ", " ", " ", " ", " ", " ", " ", " ", " "];
      this.turn = "player";
      this.gameOver = false;
    }

    Game.prototype.playerMove = function(position) {
      if (this.gameOver) {
        return this.gameOverError();
      }
      if (this.checkLocation(position) === " " && this.turn === "player") {
        this.board[position] = "X";
        return this.changeTurn();
      } else {
        return this.illegalTurnError();
      }
    };

    Game.prototype.checkLocation = function(position) {
      return this.board[position];
    };

    Game.prototype.computerMove = function() {
      var position;

      if (this.gameOver) {
        return this.gameOverError();
      }
      position = this.computerLogic();
      if (this.checkLocation(position) === " " && this.turn === "computer") {
        this.board[position] = "O";
        return this.changeTurn();
      } else {
        return this.illegalTurnError();
      }
    };

    Game.prototype.changeTurn = function() {
      return this.turn = this.turn === "player" ? "computer" : "player";
    };

    Game.prototype.computerLogic = function() {};

    Game.prototype.raiseError = function(call) {
      return alert(call);
    };

    Game.prototype.checkStatus = function() {
      if (this.playerWin() || this.computerWin() || this.isDraw()) {
        this.gameOver = true;
      }
      if (this.gameOver) {
        if (this.playerWin()) {
          return this.playerWon();
        }
        if (this.computerWin()) {
          return this.computerWon();
        }
        if (this.isDraw()) {
          return this.nobodyWon();
        }
      }
    };

    Game.prototype.winnerAlert = function(who) {
      return alert("" + who + " has won this round");
    };

    Game.prototype.playerWin = function() {};

    Game.prototype.playerWon = function() {
      return this.winnerAlert(this.player.name);
    };

    Game.prototype.computerWin = function() {};

    Game.prototype.computerWon = function() {
      return this.winnerAlert("computer");
    };

    Game.prototype.isDraw = function() {};

    Game.prototype.nobodyWon = function() {
      return this.winnerAlert("DRAW: nobody");
    };

    Game.prototype.gameOverError = function() {
      return this.raiseError("Illegal Move: the game is over, no more moves allowed");
    };

    Game.prototype.illegalTurnError = function() {
      return this.raiseError("Illegal Move: move taken out of turn");
    };

    return Game;

  })();

  window.Game = Game;

}).call(this);
