class CreateWords < ActiveRecord::Migration[8.0]
  def change
    create_table :words do |t|
      t.belongs_to :assignment, null: false, foreign_key: true
      t.string :original_text
      t.string :translated_text
      t.string :original_text_error1
      t.string :original_text_error2
      t.string :original_text_error3
      t.string :translated_text_error1
      t.string :translated_text_error2
      t.string :translated_text_error3

      t.timestamps
    end
  end
end
