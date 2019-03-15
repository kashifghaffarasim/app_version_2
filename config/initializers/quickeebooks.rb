
QB_KEY= "qyprdOybbCGiKWOBRyPtqq5Xhch6Zy"
QB_SECRET = "g33Gy5qSf8bqnz66aMhmZFH56pKNlAs4WfC9L4ia"
$qb_oauth_consumer = OAuth::Consumer.new(QB_KEY, QB_SECRET, {
	:site                 => "https://oauth.intuit.com",
	:request_token_path   => "/oauth/v1/get_request_token",
	:authorize_url        => "https://appcenter.intuit.com/Connect/Begin",
	:access_token_path    => "/oauth/v1/get_access_token"
})

Quickbooks.sandbox_mode = true

