# frozen_string_literal: true

module Api
  module V1
    class ApiController < ApplicationController
      include ErrorHandler

      before_action :authenticate_user!
    end
  end
end
