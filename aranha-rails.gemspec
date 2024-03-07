# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'aranha/rails/version'

Gem::Specification.new do |s|
  s.name        = 'aranha-rails'
  s.version     = Aranha::Rails::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{app,config,db,lib}/**/*']
  s.required_ruby_version = '>= 2.7'

  s.add_dependency 'aranha', '~> 0.19', '>= 0.19.2'
  s.add_dependency 'aranha-parsers', '~> 0.22'
  s.add_dependency 'eac_active_scaffold', '~> 0.5', '>= 0.5.3'
  s.add_dependency 'eac_rails_delayed_job', '~> 0.2', '>= 0.2.1'
  s.add_dependency 'eac_rails_utils', '~> 0.22', '>= 0.22.3'
  s.add_dependency 'eac_ruby_utils', '~> 0.121'
  s.add_dependency 'rails', '>= 5.2.8.1', '< 7'

  s.add_development_dependency 'eac_rails_gem_support', '~> 0.9', '>= 0.9.2'
end
