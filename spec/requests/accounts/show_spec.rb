# frozen_string_literal: true

require 'rails_helper'

describe 'Accounts Show', type: :request do
  describe 'GET /api/v1/accounts/:id' do
    subject { get api_v1_account_path(id), headers: headers }

    let!(:account) { create(:user).account }

    before { subject }

    context 'without jwt token' do
      let(:headers) { {} }
      let(:id) { account.id }

      it { expect(response).to have_http_status :unauthorized }
    end

    context 'with invalid jwt' do
      let(:headers) { { Authorization: 'Bearer 1234' } }
      let(:id) { account.id }

      it { expect(response).to have_http_status :unauthorized }
    end

    context 'with invalid user' do
      let(:headers) { request_headers_jwt(create(:user)) }
      let(:id) { account.id }

      it { expect(response).to have_http_status :unauthorized }
    end

    context 'with valid user' do
      let(:headers) { request_headers_jwt(account.user) }
      let(:id) { account.id }

      it { expect(response).to have_http_status :ok }
      it { expect(body).to match_response_schema('api/v1/accounts/show') }
    end
  end
end
