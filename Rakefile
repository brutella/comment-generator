require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/testtask'

specification = Gem::Specification.new do |spec|
  spec.author = 'Matthias Hochgatterer'
  spec.name = 'cogen'
  spec.version = '0.0.3'
  spec.summary = 'A ruby based comment generator'
  spec.files = FileList['lib/**/*.rb', 'bin/*', '[A-Z]*', 'test/**/*'].to_a
end

Rake::GemPackageTask.new(specification) do |package| 
  package.need_tar = true
end