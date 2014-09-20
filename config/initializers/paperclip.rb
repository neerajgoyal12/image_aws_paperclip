# config/initializers/paperclip.rb
Paperclip::Attachment.default_options.merge!(
  storage:              :s3,
  url:                  ':s3_domain_url',
  path:                 ':class/:attachment/:id/:style/:filename',
  s3_credentials:       Rails.configuration.aws,
  s3_permissions:       :public_read,
  s3_protocol:          'https'
)