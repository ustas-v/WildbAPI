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
require 'rails_helper'

describe Wildberry, type: :model do
  pending "some examples to (or delete) #{__FILE__}"

  # Lazily loaded to ensure it's only used when it's needed
  # RSpec tip: Try to avoid @instance_variables if possible. They're slow.

  # let(:factory_instance) { create(:factory_name) }

  describe 'ActiveRecord associations' do
    # Describe associations model
  end

  describe 'ActiveModel validations' do
    # Describe validations model
  end

  describe 'Database structure' do
    # Describe database structure of model
  end

  describe 'Callbacks' do
    # Describe callbacks model
  end

  describe 'Scopes' do
    # Describe scopes model
  end

  describe 'Public instance methods' do
    # Describe public instance methods
  end

  describe 'Public class methods' do
    # Describe public class methods
  end

  describe 'Business logic' do
    # Describe other business logic
  end
end
