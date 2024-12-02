class Current < ActiveSupport::CurrentAttributes
  attribute :session
  attribute :user
  attribute :ignore_scoped_to_user

  def session=(session)
    super
    self.user = session&.user
  end
end
