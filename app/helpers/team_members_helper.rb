module TeamMembersHelper
  
  
  def team_user
    User.where(company_id: current_user.try(:company_id)).order(id: :asc).with_any_role(:admin, :user)
  end
  
end
