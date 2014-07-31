class CreateProductions < ActiveRecord::Migration
  def change
    create_table :productions do |t|
      t.string :name
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
