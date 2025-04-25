# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slack_big_emoji/version'

Gem::Specification.new do |s|
  s.name          = "slack-big-emoji"
  s.version       = SlackBigEmoji::VERSION
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["kinduff"]
  s.email         = ["abarcadabra@gmail.com"]

  s.summary       = %q{Command-line tool to create big emojis for Slack.}
  s.description   = %q{Slack Big Emoji is a ruby command-line tool (see support) that helps out with the generation of big emojis to a Slack team.}
  s.homepage      = "http://github.com/kinduff/slack-big-emoji"
  s.license       = "MIT"

  s.require_paths    = %w[lib]
  s.files            = `git ls-files`.split($\)
  s.executables      = %w[slack-big-emoji]
  s.test_files       = s.files.grep(%r{^spec/})
  s.extra_rdoc_files = %w[README.md]

  s.add_dependency "mechanize", "~> 2.7.5"
  s.add_dependency "highline", "~> 1.7.8"
  s.add_dependency "mini_magick", "~> 4.7.2"

  s.add_development_dependency "bundler", "~> 2.6.8"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec", "~> 3.0"
end
