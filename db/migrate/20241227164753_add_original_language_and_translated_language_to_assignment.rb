class AddOriginalLanguageAndTranslatedLanguageToAssignment < ActiveRecord::Migration[8.0]
  def change
    add_column :assignments, :original_language, :string
    add_column :assignments, :translated_language, :string
  end
end
