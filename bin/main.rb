require_relative '../config/environment.rb'

class Interface
  attr_accessor :prompt, :user


  def initialize
    @prompt = TTY::Prompt.new
    @user = {}
  end


  def login
    #initial login screen using tty-prompt.
    @prompt.say("WELCOME TO KITCHEN STALKER!
      
        ")
    sleep(1)
    @prompt.say("er...
        
        
        
        ")
        sleep(1)
    @prompt.say("WELCOME TO KITCHEN STOCKER!")
    @prompt.select("LOGIN or CREATE NEW ACCOUNT?") do |menu|
        menu.choice "LOGIN", -> {existing_user()}
        menu.choice "CREATE AN ACCOUNT", -> {new_user()}
        menu.choice "EXIT", -> {exit_program()}
        end
    end


  def new_user
    @prompt.say("Welcome, one and all!")
    user_hash = @prompt.collect do 
        key(:name).ask("What is your name?")
        end
        user_hash[:wallet] = 200.00
    @user = User.create(user_hash)
        momErrand()
        welcomeNewUser()
    end


  def existing_user
    @prompt.say("I am Andrew Ryan, and I'm here to ask you a question.
        ")
    user_name = @prompt.ask("What is your username?")
    if User.find_by(name: user_name) == nil
        @prompt.say("Sorry, we don't recognize you. Try CREATING A NEW ACCOUNT.")
        new_user()
    else
        @user = User.find_by(name: user_name)
        @prompt.say ("Welcome back, #{@user[:name]}. Let's get started.")
    end
      main_menu()    
  end


  def exit_program
    system "clear"
    @prompt.say("We all make choices, but in the end, our choices make us. 
        
        Thanks for stopping by, take care!
        
        
")
    exit!
  end


  def main_menu
    puts "Your wallet is $#{@user[:wallet]}."
    @prompt.select("qu'est-ce que c'est?") do |menu|
        menu.choice "Open fridge", -> {kitchen_items()}
        menu.choice "Go shopping", -> {shopping()}
        menu.choice "Go to work", -> {getting_money()}
       
       
        menu.choice "~*Random event*~", -> {random_event()}
        menu.choice "Exit", -> {exit_program()}
        end
        @user.save
    end


    def welcomeNewUser 
        #prints first new user screen, returns a new cli screen
            @prompt.select("Hello, #{@user[:name]}! 
                Congratulations on moving out of your parents' house. 
                
                Your mom wants to especially thank you by stocking your new fridge and giving you $200!") do |menu|
                menu.choice "Thanks, mom!", -> {main_menu()}
                menu.choice "Only $200?!", -> {ungrateful()}
        end        
    end


    def ungrateful
        @prompt.select("You are an ungrateful swine.") do |menu|
            menu.choice "I am an ungrateful swine.", -> {main_menu()}
        end
    end


    def getting_money
        @prompt.select("Okay #{@user[:name]}, you got an hour's worth of bread.") do |menu|
           # binding.pry    
            menu.choice "Take $15 for your hour of labor.", -> {@user[:wallet]}
             #   @user = User.find_by(name: @user[:name])
               # binding.pry
                @user[:wallet]+=15
                @user.save
            end
            puts "Your wallet is now $#{@user[:wallet]}."
            main_menu()
        end

    def kitchen_items #returns array of all items in your fridge
        puts "Your wallet is $#{@user[:wallet]}.
        "
        
        @prompt.select("Here's what's in your fridge.") do |menu|
            @user = User.find_by(name: @user[:name])
           # binding.pry
            #@user is User object
            #@user.items is Item object
            #items is Array
            items = @user.items.map { |item| item.name}
            #items returns "chickpeas"
            #binding.pry
            puts items
            menu.choice "I just like staring vacantly into the fridge with no real goal in mind.
    I'm not hungry, this is just something I do. Take me back home.", -> {main_menu()}
            menu.choice "Yeah, I could eat.", -> {self.eat}
            menu.choice "Macklemore, can we go grocery shopping?", -> {shopping()}
        end
    end

    def eat
        puts "Your wallet is $#{@user[:wallet]}."
        items = @user.items
       #binding.pry
        display_items = items.each_with_object({}) do |item, hash|
            hash[item.name] = item
        end  
        #item.name is the key in display_items
        #display_items is a hash of item object, 
            #first one because find_by
        ######binding.pry
        if display_items.length == 0
            @prompt.select("Looks like the only pickle we have is the one we're in. We're running on empty!") do |menu|
                menu.choice "Go shopping!", -> {shopping()}
            end
        end
        decision = @prompt.select("What would you like to eat?", display_items)
        #binding.pry
        #decision is an OBJECT in the ITEM CLASS
        #but nommers is also an object except it's in the KitchenItem class, so
        #it takes in user_id and item_id
        nommers = KitchenItem.find_by(item_id: decision.id, user_id: @user.id)
        #binding.pry
        @prompt.say("NOM NOM NOM NOM! You just ate #{decision.name}. What a tasty delight!")
        nommers.destroy
        #
        
        #binding.pry
        #puts "NOM NOM NOM NOM! You just ate #{nommers}. What a tasty delight!"
        self.kitchen_items
        # menu.choice (@user.items.map { |item| item.name})
        #binding.pry
    end
    

    def momErrand
        wholeWheatBread = Item.find_by(name:"whole wheat bread")
        KitchenItem.create(user_id: @user.id, item_id: wholeWheatBread.id)
        honeyNutCheerios = Item.find_by(name:"Honey Nut Cheerios")
        KitchenItem.create(user_id: @user.id, item_id: honeyNutCheerios.id)
        salt = Item.find_by(name: "salt")
        KitchenItem.create(user_id: @user.id, item_id: salt.id)
        pepper = Item.find_by(name: "pepper")
        KitchenItem.create(user_id: @user.id, item_id: pepper.id)
        chickpeas = Item.find_by(name: "chickpeas")
        KitchenItem.create(user_id: @user.id, item_id: chickpeas.id)
    end

     def items_names
        Item.all.map do |items|
            {"#{items.name} is #{items.price}": items.id}
         #########   binding.pry
        end
     end


     def shopping
        system "clear"
        puts "Your wallet is $#{@user[:wallet]}."
        purchase = @prompt.select("Welcome to Jay Bridge Deli", [items_names])
       # binding.pry
        purchased_item = Item.find(purchase) # object!
       # binding.pry
        @prompt.select("Are you sure you want to purchase #{purchased_item.name}?") do |menu|
            menu.choice "Yes, buy #{purchased_item.name} for #{purchased_item.price}.", -> {make_purchase(purchased_item)}
            menu.choice "Go back home.", -> {main_menu()}
         #   binding.pry
     end

    end


    def make_purchase(purchased_item) 
        #TODO: deplete wallet balance while 
        # adding to kitchen_items.
        wallet_after_purchase = @user[:wallet] - purchased_item.price
        if wallet_after_purchase <= 0
                @prompt.select("Oh man, looks like it's time to bring home some bacon.") do |menu|
                    menu.choice "Maybe we should try getting something else.", -> {shopping()}
                    menu.choice "We could always work for it!", -> {getting_money()}
            end
        end
        @user.update(wallet: wallet_after_purchase) 
      ######  nommers = KitchenItems.find_by(item_id: decision.id, user_id: @user.id)
        purchased_item_update_kitchen = Item.find_by(price: purchased_item.price)
        KitchenItem.create(user_id: @user.id, item_id: purchased_item_update_kitchen.id)
        @prompt.select("You have now just purchased #{purchased_item.name}.
            Your current wallet balance is $#{wallet_after_purchase}. 
            What would you like to do now?") do |menu|
            menu.choice "Buy more things.", -> {shopping()}
            menu.choice "Go back home.", -> {main_menu()}
        end
    end




        def random_event
         @prompt.select("“This is the central illusion in life: that randomness is a risk, that it is a bad thing...” - Nassim Nicholas Taleb") do |menu|
             menu.choice "Okay...", -> {continue0()}
            end
        end


        def continue0
            @prompt.select("I wonder what will happen...") do |menu|
                menu.choice "I am afraid.", -> {continue1()}
                menu.choice "Fuck go back.", -> {main_menu()}
            end 
        end


        def continue1
            @prompt.select("There is nothing to fear, #{@user[:name]}.") do |menu|
                 menu.choice "Sounds like something, like, really terrible is gonna happen but ok...", -> {realrandomevent()}
             end
        end


        def realrandomevent

        end


    end