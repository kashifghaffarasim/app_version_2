
Geocoder.configure(
  # Geocoding options
  # timeout: 3,                 # geocoding service timeout (secs)
  lookup: :bing,            # name of geocoding service (symbol)
  # ip_lookup: :freegeoip,      # name of IP address geocoding service (symbol)
  # language: :en,              # ISO-639 language code
  # use_https: false,           # use HTTPS for lookup requests? (if supported)
  # http_proxy: nil,            # HTTP proxy server (user:pass@host:port)
  # https_proxy: nil,           # HTTPS proxy server (user:pass@host:port)
  api_key: "AlLJXNhPF9uvdtb3hlNPWf90i1j4-Ag82VAx8F2I5XCRdoxICwz0KV8opEIb_YI3",               # API key for geocoding service
  # cache: nil,                 # cache object (must respond to #[], #[]=, and #del)
  # cache_prefix: 'geocoder:',  # prefix (string) to use for all cache keys

  # Exceptions that should not be rescued by default
  # (if you want to implement custom error handling);
  # supports SocketError and Timeout::Error
  # always_raise: [],

  # Calculation options
  # units: :mi,                 # :km for kilometers or :mi for miles
  # distances: :linear          # :spherical or :linear
)