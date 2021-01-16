class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.text :content
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :reports, [:employee_id, :created_at]
  end
end
