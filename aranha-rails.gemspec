# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'aranha/rails/version'

Gem::Specification.new do |s|
  s.name        = 'aranha-rails'
  s.version     = Aranha::Rails::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{app,config,db,lib}/**/*']
  s.test_files = Dir['spec/**/*', '.rspec', 'Gemfile', '.rubocop.yml']

  s.add_dependency 'aranha', '~> 0.15'
  s.add_dependency 'aranha-parsers', '~> 0.6'
  s.add_dependency 'eac_active_scaffold', '~> 0.1'
  s.add_dependency 'eac_rails_delayed_job', '~> 0.1'
  s.add_dependency 'eac_rails_utils', '~> 0.12', '>= 0.12.1'
  s.add_dependency 'eac_ruby_utils', '~> 0.72'
  s.add_dependency 'rails', '>= 5.1.7', '< 6'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.3', '>= 0.3.1'
end
