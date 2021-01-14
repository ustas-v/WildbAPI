# frozen_string_literal: true

require 'rails_helper'

describe Queries::Wildberries::MainItems do
  describe 'Queries' do
    subject { Queries::Wildberries::MainItems.run! }

    # On stocks - 1960 - 14
    let!(:items_on_stocks1) { create(:wildberry, price: 100, quantity_full: 5) }
    let!(:items_on_stocks2) { create(:wildberry, price: 30, quantity_full: 2) }
    let!(:items_on_stocks3) { create(:wildberry, price: 200, quantity_full: 7) }

    # To clients - 450 - 5
    let!(:items_to_clients1) { create(:wildberry, price: 50, in_way_to_client: 3) }
    let!(:items_to_clients2) { create(:wildberry, price: 150, in_way_to_client: 2) }

    # From clients - 700 - 3
    let!(:items_from_clients1) { create(:wildberry, price: 200, in_way_from_client: 2) }
    let!(:items_from_clients2) { create(:wildberry, price: 300, in_way_from_client: 1) }

    describe '#items_on_stocks' do
      let(:items_on_stocks) { subject.items_on_stocks }

      it 'returns sum amount 1960 rub' do
        expect(Money.new(items_on_stocks.price_units)).to eq(1960.to_money)
      end

      it 'returns count items 14' do
        expect(items_on_stocks.quantity_full).to eq(14)
      end
    end

    describe '#items_to_clients' do
      let(:items_to_clients) { subject.items_to_clients }

      it 'returns sum amount 450 rub' do
        expect(Money.new(items_to_clients.price_units)).to eq(450.to_money)
      end

      it 'returns count items 5' do
        expect(items_to_clients.in_way_to_client).to eq(5)
      end
    end

    describe '#items_from_clients' do
      let(:items_from_clients) { subject.items_from_clients }

      it 'returns sum amount 700 rub' do
        expect(Money.new(items_from_clients.price_units)).to eq(700.to_money)
      end

      it 'returns count items 3' do
        expect(items_from_clients.in_way_from_client).to eq(3)
      end
    end
  end
end
