class Vet < ApplicationRecord

  belongs_to :user, optional: true

  has_many :appointments

  validates :first_name, :last_name, :specialization, presence: true
  validates :email, presence: true, uniqueness: true, 
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :by_specialization, ->(spec) { where(specialization: spec) }

  before_validation :normalize_email

  private

  def normalize_email
    self.email = email.downcase.strip if email.present?
  end
end