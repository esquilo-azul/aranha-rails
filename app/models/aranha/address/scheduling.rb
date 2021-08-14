# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Aranha
  class Address < ::ActiveRecord::Base
    module Scheduling
      common_concern

      module ClassMethods
        # @return [Array<Aranha::Address>]
        def expired(time = ::Time.zone.now)
          all.select { |record| record.expired?(time) }
        end
      end

      def check_scheduling
        ::ActiveRecord::Base.transaction do
          return if processed_at.present?
          return unless allow_retry?
          return if delayed_job.present?

          job = ::Delayed::Job.enqueue(
            ::Aranha::Address::DelayedJob.new(id),
            queue: ::Aranha::Rails::Process::QUEUE
          )
          update!(delayed_job: job)
        end
      end

      def expired?(time = ::Time.zone.now)
        time >= (created_at + timeout)
      end

      def init_scheduling
        update!(tries_count: 0, last_error: nil) unless processed?
        check_scheduling
      end

      def allow_retry?
        tries_count < ::Aranha::Processor::DEFAULT_MAX_TRIES
      end

      # @return [ActiveSupport::Duration]
      delegate :timeout, to: :processor_configuration
    end
  end
end
