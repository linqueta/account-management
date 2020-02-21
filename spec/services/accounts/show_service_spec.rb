# frozen_string_literal: true

require 'rails_helper'

describe Account::ShowService, type: :module do
  describe '#perform!' do
    subject { described_class.perform!(id, user) }

    context 'without id' do
      let(:id) { nil }
      let(:user) { nil }

      it { expect { subject }.to raise_error(User::Unauthorized) }
    end

    context 'without user' do
      let(:id) { create(:account).id }
      let(:user) { nil }

      it { expect { subject }.to raise_error(User::Unauthorized) }
    end

    context 'with invalid user' do
      let(:id) { create(:account).id }
      let(:user) { create(:user) }

      it { expect { subject }.to raise_error(User::Unauthorized) }
    end

    context 'with valid user' do
      let(:account) { create(:account) }
      let(:id) { account.id }
      let(:user) { account.user }

      it { is_expected.to be_a(Account) }
    end
  end
end
