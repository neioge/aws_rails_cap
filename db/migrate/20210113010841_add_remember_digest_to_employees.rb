class AddRememberDigestToEmployees < ActiveRecord::Migration[6.0]
  def change
    add_column :employees, :remember_digest, :string
  end
end
