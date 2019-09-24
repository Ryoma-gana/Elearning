class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.integer :user_id
      t.integer :category_id
      t.integer :result
      t.boolean :is_complete, default:false

      t.timestamps
    end
  end
end
