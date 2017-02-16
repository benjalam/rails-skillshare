class AddPriceToSkills < ActiveRecord::Migration[5.0]
  def change
    add_column :skills, :price, :integer
  end
end
