# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transfer, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:source_account) }
    it { is_expected.to belong_to(:destination_account) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }
  end

  describe '#create' do
    subject do
      described_class.create!(
        source_account: source_account,
        destination_account: destination_account,
        amount: amount
      )
    end

    let(:source_account) { create(:user).account }
    let(:destination_account) { create(:user).account }
    let(:amount) { 10 }
    let(:error) { ActiveRecord::RecordInvalid }

    context 'without required fields' do
      let(:source_account) { nil }
      let(:destination_account) { nil }
      let(:amount) { nil }
      let(:error_message) { "Validation failed: Source account must exist, Destination account must exist, Amount can't be blank, Amount is not a number" } # rubocop:disable Layout/LineLength

      it { expect { subject }.to raise_error(error, error_message) }
    end

    context 'with negative amount' do
      let(:amount) { -10 }
      let(:error_message) { 'Validation failed: Amount must be greater than 0' }

      it { expect { subject }.to raise_error(error, error_message) }
    end

    context 'with zero amount' do
      let(:amount) { 0 }
      let(:error_message) { 'Validation failed: Amount must be greater than 0' }

      it { expect { subject }.to raise_error(error, error_message) }
    end

    context 'with insufficient funds' do
      let(:error_message) { 'Validation failed: Balance must be greater than 0' }

      it { expect { subject }.to raise_error(error, error_message) }
    end

    context 'with sufficient funds' do
      let!(:credit_event) { create :event, account: source_account, amount: 15 }

      context 'before create' do
        it { expect(source_account.balance).to eq(15) }
        it { expect(destination_account.balance).to eq(0) }
      end

      context 'after create' do
        before { subject }

        it { expect(source_account.balance).to eq(5) }
        it { expect(destination_account.balance).to eq(10) }
      end
    end
  end
end
