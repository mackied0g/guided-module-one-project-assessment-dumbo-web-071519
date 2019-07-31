class CreateKitchenItems < ActiveRecord::Migration[5.2]
  def change
    create_table :kitchen_items do |t|
      t.integer :user_id
      t.integer :item_id
    end
  end
end
