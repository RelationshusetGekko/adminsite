module Adminsite
  class AdminUserRole < ActiveRecord::Base

    has_and_belongs_to_many :admin_users

    validates :name, presence: true, uniqueness: true

  end
end