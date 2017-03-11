# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hyotan/version'

Gem::Specification.new do |spec|
  spec.name          = 'hyotan'
  spec.version       = Hyotan::VERSION
  spec.authors       = ['Hisaki Akaza']
  spec.email         = ['TheRed@users.noreply.github.com']

  spec.summary       = %q(A Rubyesque interface to CaboCha.)
  spec.homepage      = 'https://github.com/TheRed/hyotan'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'cabocha', '~> 0.69.1'
end
