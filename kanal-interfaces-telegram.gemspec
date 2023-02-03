# frozen_string_literal: true

require_relative "lib/kanal/interfaces/discord/version"

Gem::Specification.new do |spec|
  spec.name = "kanal-interfaces-discord"
  spec.version = Kanal::Interfaces::Discord::VERSION
  spec.authors = ["idchlife"]
  spec.email = ["idchlife@gmail.com"]

  spec.summary = "This library provides a Discord interface for Kanal"
  spec.description = "Library provides Discord interface for Kanal. With this you can connect to discord bot and control it"
  spec.homepage = "https://github.com/idchlife/kanal-interfaces-discord"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.6"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/idchlife/kanal-interfaces-discord"
  spec.metadata["changelog_uri"] = "https://github.com/idchlife/kanal-interfaces-discord"

  # spec.add_dependency "kanal", git: "git@github.com:idchlife/kanal.git"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end