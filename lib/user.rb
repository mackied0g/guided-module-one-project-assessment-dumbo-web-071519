class User < ActiveRecord::Base
    has_many :kitchen_items
    has_many :items, through: :kitchen_items
end
