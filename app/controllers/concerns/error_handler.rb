# frozen_string_literal: true

module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from User::Unauthorized, with: :render_unauthorized
    rescue_from ActionController::ParameterMissing, with: :render_unprocessable_entity
  end

  private

  def render_unauthorized
    head :unauthorized
  end

  def render_unprocessable_entity(error)
    render json: error, status: :unprocessable_entity
  end
end
