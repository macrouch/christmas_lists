class Rack::Attack
  # Lockout IP addresses that are hammering your login page.
  # After 20 requests in 1 minute, block all requests from that IP for 1 hour.
  Rack::Attack.blocklist('allow2ban login scrapers') do |req|
    # `filter` returns false value if request is to your login page (but still
    # increments the count) so request below the limit are not blocked until
    # they hit the limit.  At that point, filter will return true and block.
    Rack::Attack::Allow2Ban.filter(req.ip, maxretry: 1, findtime: 1.days, bantime: 30.days) do
      # The count for the IP is incremented if the return value is truthy.
      req.head?
    end
  end

  Rack::Attack.blocklisted_response = lambda do |env|
    # Using 503 because it may make attacker think that they have successfully
    # DOSed the site. Rack::Attack returns 403 for blocklists by default
    Rails.logger.warn "Allow2Ban - #{env['REQUEST_METHOD']} #{env['PATH_INFO']}"

    [200, {}, ['']]
  end
end
