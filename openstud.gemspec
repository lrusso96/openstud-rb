# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'openstud/version'

Gem::Specification.new do |spec|
  spec.name          = 'openstud-rb'
  spec.version       = Openstud::VERSION
  spec.authors       = ['luigi russo']
  spec.email         = ['russo.1699981@studenti.uniroma1.it']

  spec.summary       = 'openstud-driver, but in Ruby'
  spec.description   = 'a gem that interacts with Sapienza Infostud'
  spec.homepage      = 'https://github.com/lrusso96'
  spec.license       = 'MIT'
  # spec.metadata["allowed_push_host"] = 'http://mygemserver.com'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/lrusso96/openstud-rb'
  spec.metadata['changelog_uri'] = 'https://github.com/lrusso96/openstud-rb'

  # Specify which files should be added to the gem when it is released.
  # `git ls-files -z` loads the files in the RubyGem that have been added to git
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`
      .split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty'
  spec.add_dependency 'json'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov'
end
