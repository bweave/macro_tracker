module ScopedToUser
  extend ActiveSupport::Concern

  class CurrentUserNotSetError < StandardError
  end

  included do
    self.primary_key = :id
    belongs_to :user
    before_validation :ensure_scoped_to_user
    default_scope { scoped_to_user_default_scope }
  end

  module ClassMethods
    def scoped_to_user_default_scope
      if ScopedToUser.ignore?
        all
      elsif Current.user.blank?
        fail CurrentUserNotSetError,
             "You must set Current.user to access #{name} or use unscoped"
      else
        where(user_id: Current.user.id)
      end
    end

    def without_user_scope
      unscope(where: :user_id)
    end
  end

  def self.with(user, &)
    Current.set(user:, ignore_scoped_to_user: false, &)
  end

  def self.ignore(&)
    Current.set(user: nil, ignore_scoped_to_user: true, &)
  end

  def self.start_ignoring!
    Current.ignore_scoped_to_user = true
  end

  def self.finish_ignoring!
    Current.ignore_scoped_to_user = false
  end

  def self.ignore?
    Current.ignore_scoped_to_user
  end

  def ensure_scoped_to_user
    return if ScopedToUser.ignore?

    if Current.user.blank? && blank_user_id?
      fail CurrentUserNotSetError,
           "You must set Current.user to save #{self} or set organization_id"
    elsif new_record?
      self.user_id = Current.user.id
    end
  end

  def blank_user_id?
    user_id.blank? || user_id.zero?
  end
end
