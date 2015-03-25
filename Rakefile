require './app'

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = "spec/*/*.rb"
  t.verbose = true
end

Dir.glob('lib/tasks/*.rake').each { |r|
  import r
}
