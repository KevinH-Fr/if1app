class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  enum role: [:user, :moderator, :admin]
  after_initialize :set_default_role, :set_default_name, :if => :new_record?
  def set_default_role
    self.role ||= :user
  end

  def set_default_name
    self.nom ||= "username default"
  end


  def full_name
    "#{id} | #{email}"
 end


end
