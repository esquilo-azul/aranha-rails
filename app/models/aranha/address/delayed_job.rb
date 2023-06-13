# frozen_string_literal: true

require 'aranha/address_processor'
require 'eac_ruby_utils/core_ext'

module Aranha
  class Address < ::ActiveRecord::Base
    class DelayedJob
      common_constructor :address_id

      def perform
        ::Rails.logger.info("Processing \"#{address}\"")
        address_processor.successful? ? perform_on_success : perform_on_error
      end

      private

      def address
        address_processor.address
      end

      def perform_on_success
        # Do nothing
      end

      def perform_on_error
        address.update!(
          tries_count: address.tries_count + 1,
          last_error: address_processor.error.to_yaml
        )
        address.check_scheduling
      end

      def address_processor
        @address_processor ||= ::Aranha::AddressProcessor.new(
          ::Aranha::Address.find(address_id)
        )
      end
    end
  end
end
