# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'aranha/rails/version'

Gem::Specification.new do |s|
  s.name        = 'aranha-rails'
  s.version     = Aranha::Rails::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{app,config,db,lib}/**/*']
  s.required_ruby_version = '>= 3.2'

  s.add_dependency 'aranha', '~> 0.20'
  s.add_dependency 'aranha-parsers', '~> 0.27'
  s.add_dependency 'eac_active_scaffold', '~> 0.8', '>= 0.8.1'
  s.add_dependency 'eac_rails_delayed_job', '~> 0.3'
  s.add_dependency 'eac_rails_utils', '~> 0.28', '>= 0.28.1'
  s.add_dependency 'eac_ruby_utils', '~> 0.131', '>= 0.131.1'
  s.add_dependency 'rails', '>= 6.1.7.10'

  s.add_development_dependency 'eac_rails_gem_support', '~> 0.12', '>= 0.12.2'
end
