# frozen_string_literal: true

module MainHelper
  def format_money_units(amount)
    Money.new(amount).format
  end
end
