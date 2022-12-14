class User < ApplicationRecord
  has_many :foods, dependent: :destroy
  has_many :recipes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, allow_blank: true
  has_many :foods, dependent: :destroy
  has_many :recipes, dependent: :destroy

  def admin?
    role == 'admin'
  end
end
