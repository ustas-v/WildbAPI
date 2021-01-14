# frozen_string_literal: true

module Queries
  module Wildberries
    class MainItems < ActiveInteraction::Base
      def execute
        self
      end

      def items_on_stocks
        model.select(
          'SUM(quantity_full) AS quantity_full, SUM(price_units * quantity_full) AS price_units'
        ).take
      end

      def items_to_clients
        model.select(
          'SUM(in_way_to_client) AS in_way_to_client, SUM(price_units * in_way_to_client) AS price_units'
        ).take
      end

      def items_from_clients
        model.select(
          'SUM(in_way_from_client) AS in_way_from_client, SUM(price_units * in_way_from_client) AS price_units'
        ).take
      end

      private

      def model
        Wildberry
      end
    end
  end
end
