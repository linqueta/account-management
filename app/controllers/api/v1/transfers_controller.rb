# frozen_string_literal: true

module Api
  module V1
    class TransfersController < ApiController
      def create
        render json: Transfer::CreateService.perform!(params, current_user),
               serializer: TransferSerializer,
               status: :created
      end
    end
  end
end
