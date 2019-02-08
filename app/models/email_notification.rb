class EmailNotification < ApplicationRecord
	self.per_page = 25
	has_attached_file :attachment,:use_timestamp => false
	validates_attachment_content_type :attachment, :content_type => ['image/jpg','image/gif','image/jpeg', 'image/png','text/css', 'application/pdf','application/js', 'text/plain', 'text/x-json', 'application/json', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document','application/zip','application/vnd.openxmlformats-officedocument.spreadsheetml.sheet','application/vnd.ms-excel','application/xls','application/xlsx','application/octet-stream','application/javascript','application/x-javascript', 'text/javascript', 'text/x-javascript', 'text/x-json','text/html', 'application/xhtml', 'application/xml', 'text/xml', 'text/js']


end
