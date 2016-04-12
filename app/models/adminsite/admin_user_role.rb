module Adminsite
  class AdminUserRole < ActiveRecord::Base

    has_and_belongs_to_many :admin_users

    validates :name, presence: true, uniqueness: true

    before_validation :downcase_name

    protected

    def downcase_name
      self.name = name.try(:downcase)
    end

  end
end