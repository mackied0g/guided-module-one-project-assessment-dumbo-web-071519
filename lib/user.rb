class User < ActiveRecord::Base
    has_many :kitchen_items
    has_many :items, through: :kitchen_items

        def userItems
    # #     #sum all of specific user's items
            self.items.map do |item|
                item.price

            end
    # #     # get the @user instance
    # #     # get all @user kitchen items
    # #     # kitchen item prices
    # #     # total_kitchen_item_amount
    # #     self.
        
     end
end
