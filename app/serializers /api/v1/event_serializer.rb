# frozen_string_literal: true

module Api
  module V1
    class EventSerializer < ActiveModel::Serializer
      attributes :amount
    end
  end
end
