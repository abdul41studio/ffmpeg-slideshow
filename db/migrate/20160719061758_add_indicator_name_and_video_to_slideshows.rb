class AddIndicatorNameAndVideoToSlideshows < ActiveRecord::Migration[5.0]
  def change
    add_column :slideshows, :indicator_name, :string
    add_column :slideshows, :video, :string
  end
end
