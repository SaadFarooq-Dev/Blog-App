class DropBodyFromPost < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :body, :text
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
