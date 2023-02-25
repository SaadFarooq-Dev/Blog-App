class AddParentToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :parent_id, :integer, null: true
    # Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
