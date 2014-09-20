class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :ulr
      t.references :user, index: true

      t.timestamps
    end
  end
end
