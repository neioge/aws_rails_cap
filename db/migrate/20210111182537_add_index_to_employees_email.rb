class AddIndexToEmployeesEmail < ActiveRecord::Migration[6.0]
  def change
    add_index :employees, :email, unique: true
  end
end
