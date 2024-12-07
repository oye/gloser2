class Word < ApplicationRecord
  belongs_to :assignment
  validates_presence_of :original_text, :translated_text
  validates_presence_of :original_text_error1, :translated_text_error1, :original_text_error2, :translated_text_error2, :original_text_error3, :translated_text_error3, if: :assignment_has_wrong_translations?

  private
  def assignment_has_wrong_translations?
    assignment.wrong_translations?
  end
end
