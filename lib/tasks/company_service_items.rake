task :service_items => :environment do

  @service_items = ["Filter Cleaned", "Backwash (sand filter)" , "Brushing walls" , "Skimming Surface",
    "Waterline tiles cleaned", "Cleaned Skimmer Baskets", "Netted Surface Debris",
    "Netted Surface Debris", "Pump strainer baskets", "Cleaned Pump Basket", "Vacuumed Pool", "Checked Water Level",
    "Inspected Pump", "Pool Sweep / Cleaner", "NET surface & bottom", "Inspect Pool & Spa Equipment",
    "Wipe ladder and handrails", "Adjust TimeClock as needed", "ADD water as needed", "Filter Pressure Monitor",
    "Customer Note asd"
  ]
  ServiceItem.delete_all
  id = 1
  @service_items.each do |i|
    begin
      ServiceItem.create(name: i, is_used: false)
      id = id + 1
    rescue => e
      puts"ssssssssssssssssssssssssss", e.inspect
    end
  end
end

desc "Task description"
task :super_admin =>:environment do
  @admin  = User.new(email: "admin@super.com",password: '12345678')
  @already = User.find_by_email(@admin.email)
  if @already.blank?
    if @admin.save
      @admin.add_role :super_admin
      puts" Admin created ........."
    else
      puts" Somthing worng Try again..."
    end
  else
   puts" Email Already in Used.."
 end
end


task :user_all =>:environment do
  i =  0
    50.times do
      puts "sssss"
    begin
      @user = User.new(first_name: "sssssssss", password: '12345678',last_name:"sssssssaaa", email: "sssssssssssss@gm.com#{i}",company_id: "16" ,source: "map", username: "aaaaaa",phone_number: "+223333", mobile_number: "qqqq")
      if @user.save
        @user.add_role :customer
        puts"nananna"
        @address = Address.new({:address_name => "lahore pakistan",:city_name => "lahore",:state_name => "punjab",:country_name => "pakistan",:zipcode => "5400"})
        @address.user_id = @user.try(:id)
        if @address.save
          puts"nananna" ,@address.inspect
          i = i + 1
        end 
      end 
    rescue raise_user_error

      puts "sssss=----------------#{raise_user_error}"
    end
    
  end 
end