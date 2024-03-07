# frozen_string_literal: true

require 'active_record/base'
require 'aranha/processor'
require 'aranha/rails/process'
require 'delayed_job'
require 'eac_ruby_utils/core_ext'

module Aranha
  class Address < ::ActiveRecord::Base
    module Scheduling
      common_concern

      DEFAULT_PRIORITY = 0

      module ClassMethods
        # @return [Array<Aranha::Address>]
        def expired(time = ::Time.zone.now)
          all.select { |record| record.expired?(time) }
        end
      end

      def check_scheduling
        ::ActiveRecord::Base.transaction do
          return unless schedule? # rubocop:disable Rails/TransactionExitStatement

          job = ::Delayed::Job.enqueue(
            ::Aranha::Address::DelayedJob.new(id),
            queue: ::Aranha::Rails::Process::QUEUE,
            priority: priority
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

      def priority
        processor_configuration.if_present(DEFAULT_PRIORITY, &:priority)
      end

      def schedule?
        processed_at.blank? && allow_retry? && delayed_job.blank? && enabled?
      end

      delegate :enabled?, :timeout, to: :processor_configuration
    end
  end
end
