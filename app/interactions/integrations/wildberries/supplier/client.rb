# frozen_string_literal: true

module Integrations
  module Wildberries
    module Supplier
      class Client < ::Integrations::Base

        base_uri Settings.api.wildberries.supplier.base_uri

        RESOURCES = {
          stocks: 'Stocks'
        }.freeze

        def api_prefix
          'supplier'
        end

        def param_token_name
          :key
        end

        private

        def resource_type(resource)
          resource
        end
      end
    end
  end
end
