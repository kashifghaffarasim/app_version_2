

task :items => :environment do

  @chemicals = ["Liquid chlorine gal", "Di chlor ib" , "Tri chlor ib" , "Muriatic acid gal",
      "Dry muriatic acid lb", "Bromine tans", "Soda ash lb", "Sodium bicarbonate lb",
      "Salt bags", "Water clarifier oz", "Algacide oz", "Phosphate remover"
  ]
  id = 1
	@chemicals.each do |i|
		ChamicalItem.create(id: id, name: i)
    id = id + 1
	end
end
