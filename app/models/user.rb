class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, presence: true

  has_one :owner, dependent: :destroy
  has_one :vet, dependent: :destroy

  enum :role, { owner: 0, vet: 1, admin: 2 }, default: :owner
end