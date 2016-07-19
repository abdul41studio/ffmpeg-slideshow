class CreateSlideshows < ActiveRecord::Migration[5.0]
  def change
    create_table :slideshows do |t|
      t.string :name

      t.timestamps
    end
  end
end
