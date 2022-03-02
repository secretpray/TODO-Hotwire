class User < ApplicationRecord
  has_secure_password

  has_many :sessions, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates_format_of :email, with: /\A[^@\s]+@[^@\s]+\z/

  validates_length_of :password, minimum: 8, allow_blank: true
  # validates_format_of :password, with: /(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])/, allow_blank: true, message: "might easily be guessed"

  before_validation do
    self.email = email.downcase.strip
  end

  before_validation if: :email_changed? do
    self.verified = false
  end

  after_update if: :password_digest_previously_changed? do
    sessions.where.not(id: Current.session).destroy_all
  end

  after_create_commit do
    IdentityMailer.with(user: self).email_verify_confirmation.deliver_later
  end

  after_update_commit if: :email_previously_changed? do
    IdentityMailer.with(user: self).email_verify_confirmation.deliver_later
  end
end
