# frozen_string_literal: true

module Aranha
  class ProcessorConfigurationsController < ::ApplicationController
    before_action :configure_processor_class_options

    active_scaffold :'aranha/processor_configuration' do |conf|
      conf.columns[:processor_class].form_ui = :select
    end

    def configure_processor_class_options
      active_scaffold_config.columns[:processor_class].options =
        { options: ::Aranha::ProcessorConfiguration.processor_class_options }
    end
  end
end
