# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'associations' do
    let(:event) { create :event }

    it { expect(event).to have_many(:debit_transfers) }
    it { expect(event).to have_many(:credit_transfers) }
  end

  describe 'validations' do
    describe '#balance' do
      subject { event.validate! }

      let!(:account) { create :account }
      let(:event) { create :event, amount: amount, account: account }
      let(:error) { ActiveRecord::RecordInvalid }
      let(:error_message) { 'Validation failed: Balance must be greater than 0' }

      context 'without any old events' do
        context 'with positive event' do
          let(:amount) { 10 }

          it { is_expected.to be_truthy }
        end

        context 'with negative event' do
          let(:amount) { -10 }

          it { expect { subject }.to raise_error(error, error_message) }
        end
      end

      context 'with old events' do
        let!(:event_1) { create :event, amount: 10, account: account }
        let!(:event_2) { create :event, amount: -5, account: account }

        context 'with positive event' do
          let(:amount) { 10 }

          it { is_expected.to be_truthy }
        end

        context 'with negative event' do
          let(:amount) { -10 }

          it { expect { subject }.to raise_error(error, error_message) }
        end
      end
    end
  end
end
