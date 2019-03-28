json.success true
json.user @customers do |customer|
	json.image customer.avatar.url
	json.full_name customer.fullname if !customer.first_name.blank? and !customer.last_name.blank? 
	json.email customer.email
	json.address_name customer.address.try(:address_name)
	json.city_name customer.address.try(:city_name)
	json.state_name customer.address.try(:state_name)
	json.country_name customer.address.try(:country_name)
	json.name customer.roles.first.try(:name).capitalize  if !customer.roles.first.try(:name).blank?
end



