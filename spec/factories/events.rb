# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    amount { Random.rand(0..99).to_d }
    account
  end
end
