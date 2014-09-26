S3DirectUpload.config do |c|
  c.access_key_id     = ENV["aws_access_key_id"]
  c.secret_access_key = ENV["aws_secret_access_key"]
  c.bucket            = ENV["aws_bucket"]
  # c.region            = "s3"
  c.url = "https://#{c.bucket}.s3.amazonaws.com/"
end