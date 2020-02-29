# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jobrunner/version'

Gem::Specification.new do |spec|
  spec.name          = "jobrunner"
  spec.version       = JobRunner::VERSION
  spec.authors       = ["mahnkong"]
  spec.email         = ["mahnkong@gmx.de"]

  spec.summary       = "tool, which executes jobs similar to cron based on rufus scheduler."
  spec.homepage      = "https://github.com/mahnkong/jobrunner"
  spec.license       = "Apache 2.0"

  spec.files         = `find . -type f \\\(  ! -iname ".*" \\\)`.split().reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ['jobrunner']
  spec.require_paths = ["lib"]

  spec.add_dependency "sinatra"
  spec.add_dependency "rufus-scheduler"
  spec.add_dependency "tzinfo-data"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end

