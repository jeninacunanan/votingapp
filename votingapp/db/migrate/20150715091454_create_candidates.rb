class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.belongs_to :position, index: true
      t.string :first_name
      t.string :last_name
      t.text :slogan

      t.timestamps null: false
    end
  end
end
