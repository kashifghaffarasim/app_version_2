json.success true
json.pool do 
	json.customer         @pool.user.fullname rescue ""
	json.city             @pool.address.try(:city_name)
	json.state            @pool.address.try(:state_name)
	json.country          @pool.address.try(:country_name)
	json.status           @pool.try(:pool_activity)
	json.pool_name        @pool.try(:pool_name) 
	json.pool_description @pool.try(:pool_description) 
	json.pool_volume      @pool.try(:pool_volume) 
	json.pool_volume2     @pool.try(:pool_volume2) 
	json.pool_gate_code   @pool.try(:pool_gate_code) 
	json.pool_source_type @pool.try(:pool_source_type)
	json.pool_lifeguards  @pool.try(:pool_lifeguards)
	json.pool_activity    @pool.try(:pool_activity)
end

