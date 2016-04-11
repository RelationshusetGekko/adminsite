module Adminsite
  class AdminUser < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :token_authenticatable, :confirmable, :lockable and :timeoutable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    has_and_belongs_to_many :admin_user_roles

  end

end
