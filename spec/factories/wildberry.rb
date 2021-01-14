# frozen_string_literal: true

FactoryBot.define do
  factory :wildberry do
    sequence(:nmid) { |n| n + 1 }
    last_change_date { DateTime.now }
  end
end
