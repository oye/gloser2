class Assignment < ApplicationRecord
  has_many :words, dependent: :destroy
  accepts_nested_attributes_for :words, reject_if: proc { |attributes| attributes["original_text"].blank? || attributes["translated_text"].blank? }, allow_destroy: true
end
