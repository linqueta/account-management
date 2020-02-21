# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'associations' do
    let(:event) { create :event }

    it { expect(event).to belong_to(:account) }
  end

  describe 'validations' do
    describe '#positive_balance' do
      subject { event.validate! }

      let!(:account) { create :account }
      let(:event) { create :event, amount: amount, account: account }
      let(:error) { ActiveRecord::RecordInvalid }
      let(:error_message) { 'Validation failed: Amount Your balance must be positive!' }

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
