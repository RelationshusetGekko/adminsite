class Profile < ActiveRecord::Base

  attr_accessor     :password
  before_save       :encrypt_password
  before_validation :prepare_email
  before_validation :generate_public_key, :on => :create

  validates_uniqueness_of :email, :message => "E-mail er allerede i brug",   :allow_nil => true

  # GEM: validates_email_format_of
  validates :email, :email_format => {:message => 'er ikke gyldig'},
                    :allow_nil    => true,
                    :allow_blank  => true

  class << self
    def authenticate(email, password)
      user = find_by_email(email)
      if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
        return user
      end
      return nil
    end

    def created_at_date(date)
      where("DATE(created_at) <= ?", date)
    end

    def with_email
      where("email IS NOT NULL")
    end

    def containing_text(text)
      where("email LIKE :t
             OR public_key LIKE :t",
            { :t => "%#{text}%" })
    end
  end

  def password_present?
    password_hash.present? && password_salt.present?
  end

  alias has_given_permission? permission?

  def permission=(flag)
    return if has_given_permission?
    if ActiveRecord::ConnectionAdapters::Column.value_to_boolean(flag)
      timestamp :permission_given_at
      self.update_attributes(:unsubscribed_at => nil)
    end
  end

  def permission?
    return false if unsubscribed?
    permission_given_at.present?
  end

  def unsubscribe!
    return nil if unsubscribed?
    self.update_attributes(:permission_given_at => nil)
    timestamp :unsubscribed_at
  end

  def unsubscribed?
    unsubscribed_at.present?
  end

  protected

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def generate_public_key
    self.public_key = ActiveSupport::SecureRandom.hex(6) #The length of the result string is twice of n.
  end

  def prepare_email
    return if self.email.blank?
    self.email.try(:strip!).try(:downcase!)
  end

  def timestamp(attribute)
    self.update_attributes(attribute => Time.zone.now)
  end
end