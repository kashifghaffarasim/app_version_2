Paperclip.options[:content_type_Spoof] = {
  #:mp3 => "application/octet-stream",
  :attachment => "application/json",
  :arabics_attachment => "application/json",
  :audio => "application/octet-stream"
}


Paperclip.options[:content_type_mappings] = {
	:arabics_attachment => "application/json",
	:attachment => "application/json"																																																																																																																																																																																																													 "application/json"
}
Paperclip::DataUriAdapter.register
