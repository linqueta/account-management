# frozen_string_literal: true

require 'rails_helper'

describe Transfer::CreateService, type: :module do
  describe '#perform!' do
    subject { described_class.perform!(params, user) }

    let(:params) do
      ActionController::Parameters
        .new(
          transfer: {
            source_account_id: source_account.id,
            destination_account_id: source_account.id,
            amount: 10

          }
        )
    end
    let(:source_account) { create(:user).account }
    let(:destination_account) { create(:user).account }
    let(:user) { nil }

    context 'without any params' do
      let(:params) { ActionController::Parameters.new({ transfer: {} }) }

      it { expect { subject }.to raise_error(ActionController::ParameterMissing) }
    end

    context 'without user' do
      let(:user) { nil }

      it { expect { subject }.to raise_error(User::Unauthorized) }
    end

    context 'with invalid user' do
      let(:user) { destination_account.user }

      it { expect { subject }.to raise_error(User::Unauthorized) }
    end

    context 'with valid user' do
      let!(:event) { create :event, amount: 20, account_id: source_account.id }
      let(:user) { source_account.user }

      it { is_expected.to be_a(Transfer) }
    end
  end
end
