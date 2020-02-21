# frozen_string_literal: true

module Api
  module V1
    class AccountsController < ApiController
      def show
        render json: Account::ShowService.perform!(params[:id], current_user), serializer: AccountSerializer
      end
    end
  end
end
