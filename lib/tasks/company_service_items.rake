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
