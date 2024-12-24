class Assignment < ApplicationRecord
  has_many :words, dependent: :destroy
  accepts_nested_attributes_for :words, reject_if: :all_blank, allow_destroy: true
  validates_associated :words
  validates_presence_of :words

  validates :name, presence: true

  before_create :generate_codes

  private
  def generate_codes
    loop do
      self.public_task_code = SecureRandom.alphanumeric(4).downcase
      self.private_task_code = SecureRandom.hex(16)
      break unless Assignment.exists?(public_task_code: public_task_code) || Assignment.exists?(private_task_code: private_task_code)
    end
  end
end
