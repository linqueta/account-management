# frozen_string_literal: true

FactoryBot.define do
  factory :transfer do
    source_account { create(:user).account }
    destination_account { create(:user).account }
    amount { 10 }

    before :create do |transfer|
      create :event, amount: 15, account: transfer.source_account
    end
  end
end
