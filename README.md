### Unbeatable TicTacToe
##### by ZachmoKahn
(Here is a [demo](http://zacharyjdavy.com/ttt-specs) of the game)

#### Running the game Locally
1. Clone the Repo and cd into the folder
```
git clone https://github.com/zachmokahn/TicZacToe.git
cd TicZacToe
```

2. Start the server
```
rake server
```
  * ( This app is using python simpleserver, to use something else update the Rakefile to launch your prefered server )

3. Start the game
```
rake play
```
  * ( This app is using python simpleserver, if you are useing something else just make sure to update the Rakefile to open localhost on the approriate port )

#### Testing
* Unit Tests: [Jasmine](http://zacharyjdavy.com/ttt-specs)
* Acceptance Tests: CasperJS

#### Running the Acceptance Tests
1. Clone the Repo and cd into the folder
```
git clone https://github.com/zachmokahn/TicZacToe.git
cd TicZacToe
```

2. Make Sure you have the development version of casperjs
```
brew update && brew install casperjs --devel
```
  * ( At the time of this post brew downloads the latest release of phantomjs with CasperJS however CasperJS 1.0.x does not support phantomjs version >= 1.9. This is why I recomment the latest development release which does support the latest release of phantomjs )

3. Start the server
```
rake server
```
  * ( This app is using python simpleserver, to use something else update the Rakefile to launch your prefered server )

4. Run the Specs
```
rake casper
```
  * ( This app is using  python simpleserver, if you are using another service make sure to update the spec/casperjsSpecs/playSpec.js file to launch the tests on the appropriate port )

===

using the # [HTML5 Boilerplate](http://html5boilerplate.com)
