# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :user, inverse_of: :account
end
