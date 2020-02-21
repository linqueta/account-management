# frozen_string_literal: true

module Api
  module V1
    class AccountSerializer < ActiveModel::Serializer
      attributes :id, :balance
    end
  end
end
