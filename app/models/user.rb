class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :receipts
  has_many :groups

  validates :first_name, :last_name, :job_title, presence: true
  validates :manager, inclusion: {in: [true, false]}
end
