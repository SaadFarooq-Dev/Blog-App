class ChangeRoleInUser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :role, :integer, default: 0
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
