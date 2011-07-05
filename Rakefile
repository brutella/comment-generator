require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/testtask'

specification = Gem::Specification.new do |spec|
  spec.author = 'Matthias Hochgatterer'
  spec.name = 'commentgen'
  spec.version = '0.0.2'
  spec.summary = 'A ruby based comment generator'
  spec.files = FileList['lib/**/*.rb', 'bin/*', '[A-Z]*', 'test/**/*'].to_a
  spec.executables = ['commentgen']
end

Rake::GemPackageTask.new(specification) do |package| 
  package.need_tar = true 
end