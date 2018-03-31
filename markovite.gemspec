
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "markovite/version"

Gem::Specification.new do |spec|
  spec.name          = "markovite"
  spec.version       = Markovite::VERSION
  spec.authors       = ["Alexandra Wright"]
  spec.email         = ["superbiscuit@gmail.com"]

  spec.summary       = "A markov chain generator that is simple to use and easy to hack."
  spec.description   = "Doctors hate this one weird trick that generates really good looking gibberish! \n Markovite is simple, but powerful markov chain generator that is designed to be hackable to your heart's delight"
  spec.homepage      = "https://github.com/f3mshep/ruby_markovify"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.require_paths = ["lib", "config"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
end
