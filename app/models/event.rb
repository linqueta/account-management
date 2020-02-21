# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :account, inverse_of: :events

  validate :positive_balance, on: :create

  private

  def positive_balance
    errors.add(:amount, 'Your balance must be positive!') unless positive_balance?
  end

  def positive_balance?
    (account.balance + amount).positive?
  end
end
