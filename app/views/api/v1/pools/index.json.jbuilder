json.success true
json.pool @pools do |pool|
	json.customer pool.user.fullname rescue ""
	json.pool_name  pool.try(:pool_name)
	json.pool_type pool.try(:pool_type)
	json.city pool.address.try(:city_name)
	json.state  pool.address.try(:state_name)
	json.country pool.address.try(:country_name)
	json.status  pool.try(:pool_activity)
end



