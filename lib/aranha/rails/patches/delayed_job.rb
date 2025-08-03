# frozen_string_literal: true

model = Delayed::Backend::ActiveRecord::Job
model.has_one :aranha_address, class_name: 'Aranha::Address', foreign_key: :delayed_job_id,
                               dependent: :nullify, inverse_of: :delayed_job
