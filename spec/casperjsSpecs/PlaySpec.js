casper.test.comment('Initial Game Board')
casper.test.begin('Empty Board', 5, function(){
  casper.start('http://localhost:8000', function(){
    this.test.assertExists('#game', 'Game Board is present');
    this.test.assertElementCount('.row', 3);
    this.test.assertElementCount('.boardPiece', 9);
    this.test.assertDoesntExist('.cross', 'Game Board has no X\'s');
    this.test.assertDoesntExist('.circle', 'Game Board has no O\'s');
  });
  casper.run(function(){
    this.test.done();
  });
});
casper.test.begin('User Input', 10, function(){
  casper.start('http://localhost:8000', function(){
    this.test.assertExists('select#gameMode', 'Selector for game mode exists');
    this.test.assertExists('select#gameMode option[value="singlePlayer"]', 'Selector option for single player exists');
    this.test.assertExists('select#gameMode option[value="twoPlayer"]', 'Selector option for two player exists');
    this.test.assertExists('select#firstMove', 'Selector for first move exists');
    this.test.assertExists('select#firstMove option[value="player1"]', 'Selector option for first player exists');
    this.test.assertExists('select#firstMove option[value="player2"]', 'Selector option for second player exists');
    this.test.assertExists('select#playerPiece', 'Selector for players piece exists');
    this.test.assertExists('select#playerPiece option[value="X"]', 'Selector option for X exists');
    this.test.assertExists('select#playerPiece option[value="O"]', 'Selector option for O exists');
    this.test.assertExists('button#newGame', 'New Game Button is Present');
  });
  casper.run(function(){
    this.test.done();
  });
});
casper.test.begin('Start a New Game: Default Values', function(){
  casper.start('http://localhost:8000', function(){
    casper.then(function(){
      this.click('#newGame');
    });
    casper.then(function(){
      this.click('#space4');
    });
    casper.then(function(){
      this.test.assertExists('#space4.boardPiece.cross', 'X added to the middle space');
    });
    casper.then(function(){
      this.test.assertExists('#space0.boardPiece.circle', 'O added to the first space by computer');
    });
  });
  casper.run(function(){
    this.test.done();
  });
});
casper.test.begin('Start a New Game: Two Player Mode', function(){
  casper.start('http://localhost:8000', function(){
    casper.then(function(){
      this.evaluate(function(){
        document.querySelector('select#gameMode').selectedIndex = 1;
        return true
      });
    });
    casper.then(function(){
      this.click('#newGame');
    });
    casper.then(function(){
      this.click('#space4');
    });
    casper.then(function(){
      this.test.assertExists('#space4.boardPiece.cross', 'X added to the middle space');
      this.test.assertDoesntExist('.circle', 'Computer disable and does not add a piece');
    });
    casper.then(function(){
      this.click('#space0');
    });
    casper.then(function(){
      this.test.assertExists('#space0.boardPiece.circle', 'O added to the first space by player');
    });
  });
  casper.run(function(){
    this.test.done();
  });
});

casper.test.begin('Start a new Game: Player Chooses O', function(){
  casper.start('http://localhost:8000', function(){
    casper.then(function(){
      this.evaluate(function(){
        document.querySelector('select#playerPiece').selectedIndex = 1;
        return true;
      });
    });
    casper.then(function(){
      this.click('#newGame');
    });
    casper.then(function(){
      this.click('#space4');
    });
    casper.then(function(){
      this.test.assertExists('#space4.boardPiece.circle', 'O added to the middle space');
    });
    casper.then(function(){
      this.test.assertExists('#space0.boardPiece.cross', 'X added to the first space by computer');
    });
  });
  casper.run(function(){
    this.test.done();
  });
});
casper.test.begin('Start a new Game: Computer Goes First', function(){
  casper.start('http://localhost:8000', function(){
    casper.then(function(){
      this.evaluate(function(){
        document.querySelector('select#firstMove').selectedIndex = 1;
        return true;
      });
    });
    casper.then(function(){
      this.click('#newGame');
    });
    casper.then(function(){
      this.test.assertExists('#space4.boardPiece.circle', 'O added to the middle space by computer right away');
      this.test.assertDoesntExist('.cross', 'No X has been played yet to prove computer went fist');
    });
  });
  casper.run(function(){
    this.test.done();
  });
});
