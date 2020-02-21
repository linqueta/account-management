# frozen_string_literal: true

require 'rails_helper'

describe 'Transfers Create', type: :request do
  describe 'POST /api/v1/tranfers' do
    subject { post api_v1_transfers_path, headers: headers, params: params }

    let!(:account) { create(:user).account }
    let(:headers) { {} }
    let(:params) { {} }
    let(:source_account) { create(:user).account }
    let(:destination_account) { create(:user).account }
    let!(:event) { create :event, amount: 20, account_id: source_account.id }

    before { subject }

    context 'without jwt token' do
      it { expect(response).to have_http_status :unauthorized }
    end

    context 'with invalid jwt' do
      let(:headers) { { Authorization: 'Bearer 1234' } }

      it { expect(response).to have_http_status :unauthorized }
    end

    context 'without transfer params' do
      let(:headers) { request_headers_jwt(destination_account.user) }
      let(:params) { { transfer: {} } }

      it { expect(response).to have_http_status :unprocessable_entity }
    end

    context 'with invalid user' do
      let(:headers) { request_headers_jwt(destination_account.user) }
      let(:params) do
        {
          transfer: {
            source_account_id: source_account.id,
            destination_account_id: destination_account.id,
            amount: 10
          }
        }
      end

      it { expect(response).to have_http_status :unauthorized }
    end

    context 'with valid user' do
      let(:headers) { request_headers_jwt(source_account.user) }
      let(:params) do
        {
          transfer: {
            source_account_id: source_account.id,
            destination_account_id: destination_account.id,
            amount: 10
          }
        }
      end

      it { expect(response).to have_http_status :created }
      it { expect(body).to match_response_schema('api/v1/transfers/create') }
    end
  end
end
