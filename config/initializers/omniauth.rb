OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '665999610153865', 'f05fdab9e6b85d4498b551e63525f23c'
end