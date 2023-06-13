# frozen_string_literal: true

require 'aranha/manager'
require 'singleton'

module Aranha
  module Rails
    class Manager < ::Aranha::Manager
      include ::Singleton

      def add_address(url, processor, extra_data = nil)
        ::Rails.logger.info("Adding \"#{url} | #{processor} | #{extra_data}\"")
        a = ::Aranha::Address.find_or_initialize_by(url: ::Aranha::Address.sanitize_url(url))
        a.processor = processor
        a.extra_data = extra_data.to_yaml
        a.save!
        a.check_scheduling
      end

      def addresses_count
        ::Aranha::Address.count
      end

      def clear_expired_addresses
        q = ::Aranha::Address.expired(::Time.zone.now)
        ::Rails.logger.info("Addresses expired: #{q.count}")
        q.each(&:destroy)
      end

      def log_info(message)
        ::Rails.logger.info(message)
      end

      def log_warn(message)
        ::Rails.logger.warn(message)
      end

      def start_points_to_addresses
        super
        ::Aranha::StartPoint.all.each do |sp|
          add_address(sp.uri, sp.processor_class, sp.extra_data)
        end
      end

      def unprocessed_addresses
        ::Aranha::Address.all.select(&:schedule?).sort_by { |a| [a.priority] }
      end
    end
  end
end
