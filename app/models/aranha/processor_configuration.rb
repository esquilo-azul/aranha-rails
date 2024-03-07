# frozen_string_literal: true

require 'eac_ruby_utils/yaml'

module Aranha
  class ProcessorConfiguration < ::ActiveRecord::Base
    DEFAULT_TIMEOUT = 12.hours

    class << self
      # @return [Enumerator<String>]
      def processor_class_list
        ::Set.new(processor_class_list_from_addresses + processor_class_list_from_start_points)
          .to_enum.sort
      end

      # @return [Hash<String, String>]
      def processor_class_options
        processor_class_list.map { |e| [e, e] }.to_h # rubocop:disable Style/MapToHash
      end

      private

      # @return [Array<String>]
      def processor_class_list_from_addresses
        ::Aranha::Address.distinct.pluck(:processor)
      end

      # @return [Array<String>]
      def processor_class_list_from_start_points
        ::Aranha::StartPoint.processor_class_list.to_a
      end
    end

    validates :priority, numericality: { only_integer: true }
    validates :processor_class, presence: true
    validate :processor_class_in_list
    validates :timeout_seconds, allow_blank: true,
                                numericality: { integer_only: true, greater_than_or_equal_to: 1 }

    def processor_class_in_list
      return if processor_class.blank?
      return if self.class.processor_class_list.include?(processor_class)

      errors.add(:processor_class, 'Not in list')
    end

    # @return [ActiveSupport::Duration]
    def timeout
      timeout_seconds.if_present(DEFAULT_TIMEOUT, &:seconds)
    end
  end
end
