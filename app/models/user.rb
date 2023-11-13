class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :async
  
  has_many :members
  has_many :wishes
  has_many :groups, through: :members

  def full_name
    "#{first_name} #{last_name}"
  end
  
end
