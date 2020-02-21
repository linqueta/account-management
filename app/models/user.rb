# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true

  has_one :account, inverse_of: :user, dependent: :destroy

  after_create :build_account

  def build_account
    self.account = Account.create!(user: self)
  end
end
