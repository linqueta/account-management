# frozen_string_literal: true

module Api
  module V1
    class TransferSerializer < ActiveModel::Serializer
      attributes :id

      belongs_to :source_account, serializer: Api::V1::AccountSerializer
      belongs_to :source_event, serializer: Api::V1::EventSerializer
      belongs_to :destination_event, serializer: Api::V1::EventSerializer
    end
  end
end
