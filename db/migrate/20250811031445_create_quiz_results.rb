class CreateQuizResults < ActiveRecord::Migration[7.1]
  def change
        create_table :quiz_results, id: :uuid do |t|
          t.boolean :is_correct
          t.references :quiz_history, null: false, foreign_key: true, type: :uuid
          t.references :question, null: false, foreign_key: true, type: :uuid
          t.references :selected_answer_choice, foreign_key: { to_table: :answer_choices }, type: :uuid
      t.timestamps
    end
  end
end
