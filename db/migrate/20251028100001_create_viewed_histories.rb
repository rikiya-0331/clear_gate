class CreateViewedHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :viewed_histories, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :question, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :viewed_histories, %i[user_id question_id], unique: true
  end
end
