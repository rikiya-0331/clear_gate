class CreateQuizResults < ActiveRecord::Migration[7.1]
  def change
    create_table :quiz_results do |t|
      t.boolean :is_correct
      t.references :quiz_history, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
            t.references :selected_answer_choice, foreign_key: { to_table: :answer_choices }

      t.timestamps
    end
  end
end
