# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::EventSerializer, type: :model do
  describe '#as_json' do
    subject { described_class.new(event).as_json }

    let(:event) { create :event }

    it { is_expected.to eq(amount: event.amount) }
  end
end
