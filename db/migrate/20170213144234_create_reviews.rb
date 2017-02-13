class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :description
      t.string :nature
      t.integer :rating
      t.references :booking, foreign_key: true

      t.timestamps
    end
  end
end
