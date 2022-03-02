class Session < ApplicationRecord
  belongs_to :user

  after_create_commit do
    SessionMailer.with(session: self).signed_in_notification.deliver_later
  end
end
