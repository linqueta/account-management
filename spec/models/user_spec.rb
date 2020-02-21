# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_one(:account) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to allow_value(Faker::Internet.email).for(:email) }
    it { is_expected.not_to allow_value('12345').for(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe '#create!' do
    subject { create :user }

    it { expect(subject.account).to be_a(Account) }
  end
end
