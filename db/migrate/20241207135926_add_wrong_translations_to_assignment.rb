class AddWrongTranslationsToAssignment < ActiveRecord::Migration[8.0]
  def change
    add_column :assignments, :wrong_translations, :boolean
  end
end
