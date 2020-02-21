# frozen_string_literal: true

module Transferable
  extend ActiveSupport::Concern

  included do
    def self.normalized(field, suffix = nil)
      "#{field}_#{to_s.downcase}#{suffix ? "_#{suffix}" : nil}"
    end

    has_many :debit_transfers,
             class_name: 'Transfer',
             foreign_key: normalized(:source, :id),
             dependent: :destroy,
             inverse_of: normalized(:source)
    has_many :credit_transfers,
             class_name: 'Transfer',
             foreign_key: normalized(:destination, :id),
             dependent: :destroy,
             inverse_of: normalized(:destination)
  end
end
