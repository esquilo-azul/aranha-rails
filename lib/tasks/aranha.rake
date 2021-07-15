# frozen_string_literal: true

namespace(:aranha) do
  desc 'Process Aranha\'s addresses.'
  task process: :environment do
    ::Aranha::Processor.new
  end

  desc 'Remove all registered Aranha\'s addresses.'
  task clear: :environment do
    Rails.logger.info("Addresses deleted: #{::Aranha::Address.destroy_all.count}")
  end

  namespace :fixtures do
    desc 'Download remote content for fixtures.'
    task download: :environment do
      ::Aranha::Rails::FixturesDownload.new(
        ::Aranha::Rails::FixturesDownload::OPTION_EXTENSION => ENV['EXTENSION'],
        ::Aranha::Rails::FixturesDownload::OPTION_PREFIX => ENV['PREFIX'],
        ::Aranha::Rails::FixturesDownload::OPTION_DOWNLOAD => ENV['DOWNLOAD'].present?,
        ::Aranha::Rails::FixturesDownload::OPTION_PENDING => ENV['PENDING'].present?
      ).run
    end
  end
end
