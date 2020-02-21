# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::AccountSerializer, type: :model do
  describe '#as_json' do
    subject { described_class.new(account).as_json }

    let(:account) { create :account }

    it { is_expected.to eq(id: account.id, balance: account.balance) }
  end
end
