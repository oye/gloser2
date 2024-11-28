class Word < ApplicationRecord
  belongs_to :assignment
  validates_presence_of :original_text, :translated_text
  validates_presence_of :original_text_error1, :translated_text_error1, :original_text_error2, :translated_text_error2, :original_text_error3, :translated_text_error3, if: :any_error_field_has_value?

  private

  def any_error_field_has_value?
    original_text_error1.present? || translated_text_error1.present? || original_text_error2.present? || translated_text_error2.present? || original_text_error3.present? || translated_text_error3.present?
  end
end
