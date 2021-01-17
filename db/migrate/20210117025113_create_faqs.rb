class CreateFaqs < ActiveRecord::Migration[6.0]
  def change
    create_table :faqs do |t|
      t.text :question
      t.text :answer
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :faqs, [:employee_id, :created_at]
  end
end
