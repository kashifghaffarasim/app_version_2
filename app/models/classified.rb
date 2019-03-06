class Classified < ApplicationRecord
	has_many :pictures, dependent: :destroy


end
