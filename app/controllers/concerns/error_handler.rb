# frozen_string_literal: true

module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from User::Unauthorized, with: :render_unauthorized
  end

  private

  def render_unauthorized
    head :unauthorized
  end
end
