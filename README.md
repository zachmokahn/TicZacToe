###[TicTacToe](http://zacharyjdavy.com/ttt) (play the game here)
#####by ZachmoKahn

TTT done in TDD Fashion
* Unit Tests: [Jasmine](https://googledrive.com/host/0B8sRirk3z8EudldFYV9IeDRkR1k/SpecRunner.html)
* Acceptance Tests: CasperJS

#### A walkthrough on how to run the acceptance tests

1. Clone the Repo and cd into the folder
```
git clone https://github.com/zachmokahn/TicZacToe.git
cd TicZacToe
```

2. Make Sure you have the latest version of casperjs
``` 
brew update && brew install casperjs --devel
```

3. Start the server (I use python simpleserver, if you wish to use something else just make sure you update the casperjs spec)
```
rake server
```

4. Run the Specs
```
rake casper
```
===












using the # [HTML5 Boilerplate](http://html5boilerplate.com)
