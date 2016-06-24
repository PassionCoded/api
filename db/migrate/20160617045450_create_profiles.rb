class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :profession
      t.string :tech_of_choice
      t.integer :years_experience
      t.boolean :willing_to_manage

      t.timestamps null: false
    end
  end
end
