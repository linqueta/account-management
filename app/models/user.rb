# frozen_string_literal: true

class User < ApplicationRecord
  class Unauthorized < StandardError; end

  devise :database_authenticatable,
         :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtBlacklist

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_one :account, inverse_of: :user, dependent: :destroy

  after_create :build_account!

  private

  def build_account!
    self.account = Account.create!(user: self) unless account
  end

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end
