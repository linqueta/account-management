# frozen_string_literal: true

class Account
  module ShowService
    module_function

    def perform!(id, user)
      id.present? && user&.account&.id == id.to_i ? user.account : raise(User::Unauthorized)
    end
  end
end
