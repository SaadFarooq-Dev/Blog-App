class AddStatusToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :status, :integer, default: 0
    # Ex:- :default =>''
  end
end
