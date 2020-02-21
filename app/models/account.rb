# frozen_string_literal: true

class Account < ApplicationRecord
  include Transferable

  belongs_to :user, inverse_of: :account
  has_many :events, inverse_of: :account, dependent: :destroy

  def balance
    events.sum(:amount).to_f
  end
end
