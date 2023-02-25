class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.text :reason
      t.references :user, foreign_key: true
      t.references :reportable, polymorphic: true

      t.timestamps
    end
    add_index :reports, %i[reportable_id reportable_type]
  end
end
