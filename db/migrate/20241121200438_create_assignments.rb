class CreateAssignments < ActiveRecord::Migration[8.0]
  def change
    create_table :assignments do |t|
      t.string :public_task_code
      t.string :private_task_code
      t.string :name

      t.timestamps
    end
  end
end
