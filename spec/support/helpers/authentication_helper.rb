# frozen_string_literal: true

module AuthenticationHelper
  def request_headers_jwt(user)
    Devise::JWT::TestHelpers.auth_headers({}, user)
  end
end
