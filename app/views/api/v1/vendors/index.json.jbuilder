json.success true
json.user @vendors do |vendor|
	json.image vendor.avatar.url
	json.full_name vendor.fullname.titleize
	json.email vendor.email
	json.address_name vendor.address.try(:address_name).titleize
	json.city_name vendor.address.try(:city_name).titleize
	json.state_name vendor.address.try(:state_name).titleize
	json.country_name vendor.address.try(:country_name).titleize
	json.name vendor.roles.first.try(:name).titleize
end

