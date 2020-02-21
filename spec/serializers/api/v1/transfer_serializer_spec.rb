# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::TransferSerializer, type: :model do
  describe '#as_json' do
    subject { described_class.new(transfer).as_json }

    let(:transfer) { create :transfer }

    it do
      is_expected.to eq(
        id: transfer.id,
        source_account: {
          id: transfer.source_account.id,
          balance: transfer.source_account.balance
        },
        source_event: {
          amount: transfer.source_event.amount
        },
        destination_event: {
          amount: transfer.destination_event.amount
        }
      )
    end
  end
end
