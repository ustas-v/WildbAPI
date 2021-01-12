# frozen_string_literal: true

module Services
  module Wildberries
    class Importer < ActiveInteraction::Base

      date :date_from

      def execute
        results.is_a?(Array) ? save_results!(results) : results[:errors]
      end

      private

      def client
        @client ||= ::Integrations::Wildberries::Supplier::Client.run!(
          param_token: ::Settings.api.wildberries.supplier.key
        )
      end

      def results
        @results ||= client.stocks.where(dateFrom: date_from.to_s).all
      end

      def save_results!(results)
        return 0 if results.count.zero?

        import_items = []

        results.each do |item|
          import_items << {
            quantity:               item[:quantity],
            quantity_full:          item[:quantityFull],
            quantity_not_in_orders: item[:quantityNotInOrders],
            warehouse_name:         item[:warehouseName],
            in_way_to_client:       item[:inWayToClient],
            in_way_from_client:     item[:inWayFromClient],
            subject:                item[:subject],
            category:               item[:category],
            brand:                  item[:brand],
            price_units:            item[:Price].to_money.cents,
            price_currency:         Money.default_currency.iso_code,
            nmid:                   item[:nmId]
          }
        end

        ::Wildberry.delete_all and ::Wildberry.import(import_items)
      end
    end
  end
end
