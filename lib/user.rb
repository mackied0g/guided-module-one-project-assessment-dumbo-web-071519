class User < ActiveRecord::Base
    has_many :kitchen_items
    has_many :items, through: :kitchen_items

    #     def userItems
    # #     #sum all of specific user's items 
                
    #         self.items.map do |item|
    #         foo =  item.price
    #         #subtract 
    #         end
    #         #total_items = userItems.sum
    #  end
end
