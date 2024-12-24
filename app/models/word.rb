class Word < ApplicationRecord
  belongs_to :assignment
  validates_presence_of :original_text, :translated_text
  validates_presence_of :original_text_error1, :translated_text_error1, :original_text_error2, :translated_text_error2, :original_text_error3, :translated_text_error3, if: :assignment_has_wrong_translations?

  def shuffled_original_text
    shuffle_text(original_text)
  end

  def shuffled_translated_text
    shuffle_text(translated_text)
  end

  private

  def shuffle_text(text)
    shuffled_scentence = shuffle_sentence(text)
    while text == shuffled_scentence
      shuffled_scentence = shuffle_sentence(text)
    end
    shuffled_scentence
  end

  def shuffle_sentence(sentence)
    sentence.split.map { |word| word.chars.shuffle.join }.join(" ")
  end
  def assignment_has_wrong_translations?
    assignment.wrong_translations?
  end
end
