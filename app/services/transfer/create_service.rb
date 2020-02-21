# frozen_string_literal: true

class Transfer
  module CreateService
    class << self
      def perform!(params, user)
        permitted_params(params)
          .then { valid_user?(_1, user) ? _1 : raise(User::Unauthorized) }
          .then { Transfer.create!(_1) }
      end

      private

      def valid_user?(params, user)
        user&.account&.id == params[:source_account_id].to_i
      end

      def permitted_params(params)
        params.require(:transfer)
              .permit(:source_account_id, :destination_account_id, :amount)
      end
    end
  end
end
