Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET'], skip_jwt: true
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  provider :identity,
    on_login: -> (env) { SessionsController.action(:new).call(env) },
    on_registration: -> (env) { IdentitiesController.action(:new).call(env) },
    on_failed_registration: -> (env) { IdentitiesController.action(:new).call(env) }
end

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}

OmniAuth.config.full_host = Rails.env.production? ? 'https://christmas.sleekcoder.com' : 'http://localhost:3000'
