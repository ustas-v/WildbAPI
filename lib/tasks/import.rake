# frozen_string_literal: true

namespace :imports do

  desc 'Import Wildberries stocks'
  task wildberries_stocks: :environment do
    ::Services::Wildberries::Importer.run! date_from: Date.current
  end
end