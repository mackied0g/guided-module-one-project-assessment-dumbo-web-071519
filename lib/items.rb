class Item < ActiveRecord::Base
    has_many :kitchen_items
    has_many :users, through: :kitchen_items
    def list_of_item_owners
        #Item can see array of names of people who 
            #currently have that item in kitchen.
            #Active Record creates relationship between
            #Item model and User model so that one would not have
            # to go through kitchen_items to retrieve data.
            self.users.map do |user|
                user.name

            end
    end


end