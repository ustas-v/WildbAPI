# frozen_string_literal: true

require 'rails_helper'

describe Services::Wildberries::Importer do
  describe 'Import and save data' do
    subject { Services::Wildberries::Importer.run! date_from: Date.current }

    let(:mock_results) do
      [
        {
          quantity:            0,
          quantityFull:        3,
          quantityNotInOrders: 0,
          warehouseName:       'warehouseName',
          inWayToClient:       0,
          inWayFromClient:     0,
          subject:             'subject',
          category:            'category',
          brand:               'brand',
          Price:               100,
          nmId:                1
        },
        {
          quantity:            0,
          quantityFull:        5,
          quantityNotInOrders: 0,
          warehouseName:       'warehouseName',
          inWayToClient:       0,
          inWayFromClient:     0,
          subject:             'subject',
          category:            'category',
          brand:               'brand',
          Price:               200,
          nmId:                2
        }
      ]
    end

    before { allow_any_instance_of(Services::Wildberries::Importer).to receive(:results).and_return(mock_results) }
    before { subject }

    it 'saves new data' do
      expect(Wildberry.count).to eq(2)
    end

    specify { expect(Wildberry.first.price).to eq(100.to_money) }
    specify { expect(Wildberry.first.quantity_full).to eq(3) }

    specify { expect(Wildberry.last.price).to eq(200.to_money) }
    specify { expect(Wildberry.last.quantity_full).to eq(5) }
  end
end
