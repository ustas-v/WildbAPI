# frozen_string_literal: true

# == Schema Information
#
# Table name: wildberries
#
#  id                     :bigint           not null, primary key
#  quantity               :integer          default(0), not null
#  quantity_full          :integer          default(0), not null
#  quantity_not_in_orders :integer          default(0), not null
#  warehouse_name         :string
#  in_way_to_client       :integer          default(0), not null
#  in_way_from_client     :integer          default(0), not null
#  subject                :string
#  category               :string
#  brand                  :string
#  price_units            :bigint           default(0), not null
#  price_currency         :string           default("RUB"), not null
#  nmid                   :integer          not null
#  last_change_date       :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Wildberry < ApplicationRecord
  ## Modules, constants, attr_*

  monetize :price_units

  ## Associations, delegates
  ## Validations
  ## Callbacks
  ## Scopes
  ## Other meta methods

  # TODO: Need to remove in Query object
  class << self
    def items_on_stocks
      select(
        'SUM(quantity_full) AS quantity_full, SUM(price_units * quantity_full) AS price_units'
      ).take
    end

    def items_to_clients
      select(
        'SUM(in_way_to_client) AS in_way_to_client, SUM(price_units * in_way_to_client) AS price_units'
      ).take
    end

    def items_from_clients
      select(
        'SUM(in_way_from_client) AS in_way_from_client, SUM(price_units * in_way_from_client) AS price_units'
      ).take
    end
  end

  ## Protected methods
  ## Callbacks and etc.
  protected

  ## Private methods
  ## Callbacks and etc.
  private
end
