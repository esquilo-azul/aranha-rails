# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'aranha/rails/version'

Gem::Specification.new do |s|
  s.name        = 'aranha-rails'
  s.version     = Aranha::Rails::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib}/**/*']

  s.add_dependency 'active_scaffold', '~> 3.5', '>= 3.5.5'
  s.add_dependency 'aranha', '~> 0.15'
  s.add_dependency 'aranha-parsers', '~> 0.6'
  s.add_dependency 'eac_rails_utils', '~> 0.12', '>= 0.12.1'
  s.add_dependency 'eac_ruby_utils', '~> 0.52'
  s.add_dependency 'rails', '~> 5.1.7'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.1', '>= 0.1.2'
end
