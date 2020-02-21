# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:events) }
    it { is_expected.to have_many(:debit_transfers) }
    it { is_expected.to have_many(:credit_transfers) }
  end

  describe '#balance' do
    subject { account.balance }

    let!(:account) { create :account }
    let!(:event_1) { create :event, amount: 10, account: account }
    let!(:event_2) { create :event, amount: 15, account: account }
    let!(:event_3) { create :event, amount: -20, account: account }

    it { is_expected.to eq(5) }
  end
end
