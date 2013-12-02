desc "Start the Server on port 8000"
task :server do
  sh %{python -m SimpleHTTPServer}
end

desc "Open a browser and play the game"
task :play do
  sh %{open "http://localhost:8000"}
end

desc "Run casperjs to check integration tests"
task :casper do
  sh %{ casperjs test spec/casperjsSpecs/PlaySpec.js }
end
