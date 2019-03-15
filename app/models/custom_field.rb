class CustomField < ApplicationRecord
  
	validate :already_name
  
	def already_name
		if  CustomField.exists? ["name = ? AND applies_to = ?", self.name, self.applies_to]
			errors.add( :company_id, 'already exisits. Please select a different one.')
		end
	end 
  

end


