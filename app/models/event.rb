# frozen_string_literal: true

class Event < ApplicationRecord
  include Transferable

  belongs_to :account, inverse_of: :events

  validates :balance, numericality: { greater_than: 0 }

  private

  def balance
    persisted? ? account.balance : account.balance + amount
  end
end
