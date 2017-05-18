Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, '9ab737adea5449d78609', 'b0b8e2749beff0b1ab3ba3ed5860be4bdb37800d', scope: "user,repo,gist,read:org"
end