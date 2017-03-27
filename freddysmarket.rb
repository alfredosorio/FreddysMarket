require 'yaml'
# require 'terminal-table'

@retrieve_data = YAML.load_file("inventory.yaml")

# gets all keys
@inventory_id = @retrieve_data.keys()

# puts retrieve_data.inspect
# puts retrieve_data["FM0011"].values()

# gets all values
# puts @retrieve_data.values()

# writes changes to yaml file
# File.open("inventory.yaml", 'w') {|f| YAML.dump(retrieve_data, f) }

# System clear function
def clear
   system 'clear'
end

# Main Menu
def main_menu
  clear
  puts '*' * 54
  puts 'Welcome to Freddy\'s Market Inventory Management System'
  puts '*' * 54
  puts
  puts 'Please select an option:'
  puts '1. View Inventory'
  puts '2. Stock Adjustment'
  puts '3. Price Adjustment'
  puts
  puts 'q. Exit'
  print '> '
  input = gets.chomp.to_i

  if
    input == 1
    inventory_table_menu
  elsif
    input == 2
    stock_adjustment_menu
  elsif
    input == 3
    price_adjustment_page
  elsif
    input = 'q'
    puts "Goodbye."
  end
end

# View Inventory Page
def display_inventory_table
#  Terminal::Table.new title: 'INVENTORY', headings: ['ID', 'Category', 'Product Name', 'Quantity', 'Unit Price'], rows:

# couldn't find a way to interpret arrays of hashes into a table
var = open("inventory.yaml", 'r')
print var.read
end

def inventory_table_menu
  clear
  puts display_inventory_table
  puts
  puts 'Please select an option:'
  puts '1. Return to Main Menu'
  print '> '
  input = gets.chomp.to_i

  if
    input == 1
    clear
    main_menu
  end
end

# Stock Adjustment Menu
def stock_adjustment_menu
  clear
  puts '*' * 16
  puts 'Stock Adjustment'
  puts '*' * 16
  puts
  puts 'Please select an option:'
  puts '1. Add Goods'
  puts '2. Remove Goods'
#  puts '4. Goods Receipt Delivery'
  puts
  puts '5. Return to Main Menu'
  print '> '
  input = gets.chomp.to_i

  if
    input == 1
    add_goods_page
  elsif
    input == 2
    remove_goods_page
  elsif
    input == 5
    main_menu
  end
end

def price_adjustment_page
  clear

  puts '*' * 16
  puts 'Price Adjustment'
  puts '*' * 16
  puts
  display_inventory_table
  puts
  puts 'Please enter a product ID'
  print '> '
  input = gets.chomp.upcase

  search = @inventory_id.include?(input)

    if
      search == true
      input_product_name = @retrieve_data[input][:product_name]
      input_price = @retrieve_data[input][:unit_price]
      puts
      puts "#{input_product_name} is currently priced at #{input_price}."
      puts
      puts 'Please enter a new price ($.¢):'
      print '> '
      price_entered = gets.chomp
      new_price = '$' + "#{price_entered}"

      @retrieve_data[input][:unit_price] = new_price

      # write the change to the yaml file
      File.open("inventory.yaml", 'w') {|f| YAML.dump(@retrieve_data, f) }


      puts
      puts "Successfully updated."
      sleep 2
      clear
      puts "#{input_product_name} is now priced at #{new_price}."
      puts
      puts 'Please select an option:'
      puts '1. Remove Goods'
      puts '2. Main Menu'
      puts '3. View Inventory Table'
      puts
      print "> "
      input = gets.chomp.to_i

        if
          input == 1
          remove_goods_page
        elsif
          input == 2
          main_menu
        elsif
          input == 3
          inventory_table_menu
        end
    else
      search == false
      puts
      puts "ERROR: Product does not exist. Please try again"
      sleep 1
      add_goods_page
    end
end

# Add Goods Page
def add_goods_page
  clear

  puts '*' * 9
  puts 'Add Goods'
  puts '*' * 9
  puts
  display_inventory_table
  puts
  puts 'Please enter a product ID'
  print '> '
  input = gets.chomp.upcase

  # searches hash keys to see if value exists
  search = @inventory_id.include?(input)

    if
      search == true
      input_product_name = @retrieve_data[input][:product_name]
      input_quantity = @retrieve_data[input][:quantity]
      puts
      puts "There are currently #{input_quantity} #{input_product_name} in the inventory."
      puts
      puts 'Please enter the quantity you\'d like to add:'
      print '> '
      quantity_entered = gets.chomp.to_i
      new_total = input_quantity + quantity_entered

      # write to yaml file : note that putting the variable input_quantity in here, will assume that there is an integer attached
      @retrieve_data[input][:quantity] = new_total

      # write the change to the yaml file
      File.open("inventory.yaml", 'w') {|f| YAML.dump(@retrieve_data, f) }

      puts
      puts "Successfully updated."
      sleep 2
      clear
      puts "There are now #{new_total} #{input_product_name} in the inventory."
      puts
      puts 'Please select an option:'
      puts '1. Add Goods'
      puts '2. Stock Adjustment'
      puts '3. View Inventory Table'
      puts
      print "> "
      input = gets.chomp.to_i

        if
          input == 1
          add_goods_page
        elsif
          input == 2
          stock_adjustment_menu
        elsif
          input == 3
          inventory_table_menu
        end
    else
      search == false
      puts
      puts "ERROR: Product does not exist. Please try again"
      sleep 1
      add_goods_page
    end
end

  def remove_goods_page
    clear

    puts '*' * 12
    puts 'Remove Goods'
    puts '*' * 12
    puts
    display_inventory_table
    puts
    puts 'Please enter a product ID'
    print '> '
    input = gets.chomp.upcase

    # searches hash keys to see if value exists
    search = @inventory_id.include?(input)

      if
        search == true
        input_product_name = @retrieve_data[input][:product_name]
        input_quantity = @retrieve_data[input][:quantity]
        puts
        puts "There are currently #{input_quantity} #{input_product_name} in the inventory."
        puts
        puts 'Please enter the quantity you\'d like to remove:'
        print '> '
        quantity_entered = gets.chomp.to_i
        new_total = input_quantity - quantity_entered

        @retrieve_data[input][:quantity] = new_total

        # write the change to the yaml file
        File.open("inventory.yaml", 'w') {|f| YAML.dump(@retrieve_data, f) }


        puts
        puts "Successfully updated."
        sleep 2
        clear
        puts "There are now #{new_total} #{input_product_name} in the inventory."
        puts
        puts 'Please select an option:'
        puts '1. Remove Goods'
        puts '2. Stock Adjustment'
        puts '3. View Inventory Table'
        puts
        print "> "
        input = gets.chomp.to_i

          if
            input == 1
            remove_goods_page
          elsif
            input == 2
            stock_adjustment_menu
          elsif
            input == 3
            inventory_table_menu
          end
      else
        search == false
        puts
        puts "ERROR: Product does not exist. Please try again"
        sleep 1
        add_goods_page
      end
end

main_menu
