# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


def role_create
  Role.delete_all
  id = 1
  role = ["super owner", "owner", 'admin', 'user', 'vendor', 'customer', 'supplier', 'other']
  
  role.each do |role|
      Role.create(id: id, name: role)
      id = id + 1
  end
  
end


role_create