# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Aranha
  class Address < ::ActiveRecord::Base
    module Processor
      common_concern

      module ClassMethods
        # @return [Aranha::ProcessorConfiguration]
        def default_processor_configuration
          @default_processor_configuration ||= ::Aranha::ProcessorConfiguration.new
        end
      end

      # @return [Aranha::ProcessorConfiguration]
      def processor_configuration
        ::Aranha::ProcessorConfiguration.find_by(processor_class: processor) ||
          self.class.default_processor_configuration
      end
    end
  end
end
