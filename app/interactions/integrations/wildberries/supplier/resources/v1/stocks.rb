# frozen_string_literal: true

module Integrations
  module Wildberries
    module Supplier
      module Resources
        module V1
          class Stocks < ::Integrations::Resources::Base

            # CRUD actions implemented in Base class
            # Custom actions in here

            private

            def model
              :stocks
            end
          end
        end
      end
    end
  end
end
