desc "Run casperjs to check integration tests"
task :server do
  sh %{python -m SimpleHTTPServer}
end

task :casper do
  sh %{ casperjs test spec/casperjsSpecs/PlaySpec.js }
end
