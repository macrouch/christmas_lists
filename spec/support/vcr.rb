VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join("spec", "vcr")
  c.hook_into :webmock
  c.ignore_hosts 'www.google.com', 'localhost', '127.0.0.1'
end
