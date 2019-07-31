class Item < ActiveRecord::Base
    has_many :kitchen_items
    has_many :users, through: :kitchen_items
end