# frozen_string_literal: true

class Account
  module ShowService
    class << self
      def perform!(id, user)
        id.present? && user&.account&.id == id.to_i ? user.account : raise(User::Unauthorized)
      end
    end
  end
end
