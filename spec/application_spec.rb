# frozen_string_literal: true

require 'rails_helper'

describe AccountManagement, type: :module do
  describe '#is_a?' do
    subject { described_class.is_a?(Module) }

    it { is_expected.to be_truthy }
  end
end
