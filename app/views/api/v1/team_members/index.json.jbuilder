json.success true
json.user @team_members do |team_member|
	json.image team_member.avatar.url
	json.full_name team_member.fullname
	json.email team_member.email
	json.address_name team_member.address.try(:address_name)
	json.city_name team_member.address.try(:city_name)
	json.state_name team_member.address.try(:state_name)
	json.country_name team_member.address.try(:country_name)
	json.name team_member.roles.first.try(:name).capitalize
end
