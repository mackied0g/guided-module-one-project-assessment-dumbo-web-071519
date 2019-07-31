require_relative '../config/environment.rb'

class Interface
  attr_accessor :prompt, :user


  def initialize
    @prompt = TTY::Prompt.new
    @user = {}
  end


  def login
    @prompt.select("LOGIN or CREATE NEW ACCOUNT?") do |menu|
        menu.choice "LOGIN", -> {existing_user()}
        menu.choice "CREATE AN ACCOUNT", -> {new_user()}
        menu.choice "EXIT", -> {exit_program()}
        end
    end


  def new_user
    @prompt.say("Welcome, one and all!")
    user_hash = @prompt.collect do 
        key(:name).ask("Create a username.")
        # key(:wallet).say("Your balance is 200.00.")
        end
        user_hash[:wallet] = 200.00
    @user = User.create(user_hash)
        momErrand()
        welcomeNewUser()
    end


  def existing_user
    user_name = @prompt.ask("What is your username?")
    if User.find_by(name: user_name) == nil
        @prompt.say("Sorry, we don't recognize you. Try CREATING A NEW ACCOUNT.")
        new_user()
    else
        @user = User.find_by(name: user_name)
        #do I have to define wallet in @user here as well as line 28?
        @prompt.say ("Welcome back, #{@user[:name]}. Let's get started.")
    end
      main_menu()    
  end


  def exit_program
    @prompt.say("Have a great day!")
    exit!
  end


  def main_menu
    puts "Your wallet is $#{@user[:wallet]}."
    #  @user.save
    @prompt.select("qu'est-ce que c'est?") do |menu|
        menu.choice "Open fridge", -> {kitchen_items()}
        menu.choice "Go shopping", -> {shopping()}
        menu.choice "Go to work", -> {getting_money()}
        menu.choice "~*Random event*~", -> {random_event()}
        menu.choice "Exit", -> {exit_program()}
        end
        @user.save
    end


    def welcomeNewUser #prints first new user screen, returns a new cli screen
            @prompt.select("Hello, #{@user[:name]}! Congratulations on moving out of your parents' house. 
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
        @prompt.select("Okay #{@user[:name]}, you got this bread.") do |menu|
                menu.choice "Take $100 for your labor", -> {@user[:wallet]}
                ketchup = User.find_by(name: @user[:name])
                @user = ketchup
                #binding.pry
                @user[:wallet]+=100
                @user.save
                puts "Your wallet is now $#{@user[:wallet]}."
            end
            main_menu()
        end


    def kitchen_items#returns array of all items in your fridge
        @prompt.select("Here's what's in your fridge.", ) do |menu|
            @user = User.find_by(name: @user[:name])
            #binding.pry
            items = @user.items.map { |item| item.name}
            # binding.pry
            puts items
            menu.choice "Aw, okay.", -> {main_menu()}
            menu.choice "Yeah, I could eat.", -> {self.eat}
        end
    end

    def eat
        # binding.pry
        items = @user.items
        display_items = items.each_with_object({}) do |item, hash|
            hash[item.name] = item
        end  
        choice = @prompt.select("What would you like to eat today?", display_items)
        
        choice.destroy

        self.kitchen_items
        # menu.choice (@user.items.map { |item| item.name})
    end
    

    # def eat
    #     kitchen_items()
    #     @prompt.select("What are you in the mood for?") do |menu| 
    #         #eat_food = kitchen_items.to_str
    #         menu.choice "Eh, UberEats exists and is an inherently better app. Sorry, Mackenzie.", -> {main_menu()}
    #     end

    # end


    def momErrand
        wholeWheatBread = Item.find_by(name:"whole wheat bread")
        KitchenItem.create(user_id: @user.id, item_id: wholeWheatBread.id)
        honeyNutCheerios = Item.find_by(name: "Honey Nut Cheerios")
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
            items.name
        end
     end

     def shopping
        system "clear"
        purchase = @prompt.select("Welcome to Jay Bridge Deli", [items_names])
        Item.find_by(name: purchase)
     end


    # def random_event
    #     @prompt.select("“This is the central illusion in life: that randomness is a risk, that it is a bad thing...” - Nassim Nicholas Taleb") do |menu|
    #         menu.choice "Okay...", -> {continue0()}
    #         def continue0
    #             @prompt.select("I wonder what will happen...") do |menu|
    #                 menu.choice "I am afraid.", -> {continue1()}
    #                 def continue1
    #                     @prompt.select("There is nothing to fear, #{@user[:name]}.") do |menu|
    #                         menu.choice "Sounds like something, like, really terrible is gonna happen but ok...", -> {realrandomevent()}
    #                 end
    #         end
    # end





    end