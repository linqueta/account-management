# frozen_string_literal: true

class Transfer < ApplicationRecord
  belongs_to :source_account, class_name: 'Account'
  belongs_to :destination_account, class_name: 'Account'
  belongs_to :source_event, class_name: 'Event', optional: true
  belongs_to :destination_event, class_name: 'Event', optional: true

  validates :amount, presence: true, numericality: { greater_than: 0 }

  before_create :take

  private

  def take
    self.source_event = source_account.events.create!(amount: amount * -1)
    self.destination_event = destination_account.events.create!(amount: amount)
  end
end
