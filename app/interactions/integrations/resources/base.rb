# frozen_string_literal: true

module Integrations
  module Resources
    class Base < ActiveInteraction::Base

      object :client, class: ::Integrations::Base

      def execute
        self.where_chain = {}
        self
      end

      def find(id)
        formatted_response(
          client.get("#{model_root_path}/#{id}")
        )
      end

      def all
        params = { query: where_chain || {} }
        self.where_chain = {}

        formatted_response(
          client.get(model_root_path, params)
        )
      end

      def create(attributes)
        formatted_response(
          client.post(model_root_path, attributes)
        )
      end

      def update(id, attributes)
        formatted_response(
          client.put("#{model_root_path}/#{id}", attributes)
        )
      end

      def destroy(id)
        formatted_response(
          client.delete("#{model_root_path}/#{id}")
        )
      end

      def where(params = {})
        self.where_chain = where_chain.merge(params)
        self
      end

      private

      attr_accessor :where_chain

      def model_root_path
        "/#{[client.api_version, client.api_prefix, model].reject(&:blank?).join('/')}"
      end

      def formatted_response(response)
        # hash = JSON.parse(response.body, symbolize_names: true)
        # hash.is_a?(Array) ? hash.map(&method(:to_struct)) : to_struct(hash)

        JSON.parse(response.body, symbolize_names: true)
      rescue StandardError
        { errors: "Server responded with an error code: #{response.code}, #{response.message}" }
      end

      def to_struct(hash)
        Struct.new(*hash.keys) do
          def error?
            error.present? rescue false
          end
        end.new(*hash.values)
      end
    end
  end
end
