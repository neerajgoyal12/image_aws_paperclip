# image_aws_paperclip
An example rails 4.0 app for uploading an image to s3 bucket, with paperclip, aws-sdk and s3_direct_uploader gems .

# How to Begin 
	$ rails new image_aws_paperclip
	$ cd image_aws_paperclip/
	$ rails g scaffold user name:string
	$ rails g scaffold photo ulr user:references
	$ rake db:migrate
Don't mind the ulr was a typo you can use url or anything else you choose. 

Add this to your aaplication's Gemfile 
	gem 'paperclip'
	gem 'aws-sdk'
	gem 's3_direct_upload'
	gem 'figaro'

Then the usual 
	$ bundle install 

Forgot to add an image field which will be our paperclip attachment. So a migration like this. 
	$ rails g migration AddImageToPhotos

In your generated migration 
	class AddImageToPhotos < ActiveRecord::Migration
  		def change
  			add_attachment :photos, :image
  		end
	end

Update your models photo.rb 
	belongs_to :user
	  has_attached_file :image, styles:  { 
	  	thumb: '100x100>',
	  	mobile: '320x320>',
	  	large: '640x640>'
	  }
	validates_attachment_content_type :image, :content_type  => /\Aimage\/.*\Z/

And user.rb 
	has_many :photos

Rest of the code update is a mixture of 
https://devcenter.heroku.com/articles/direct-to-s3-image-uploads-in-rails#debugging
and 
http://blog.littleblimp.com/post/53942611764/direct-uploads-to-s3-with-rails-paperclip-and
and 
http://www.blitztheory.com/direct-upload-with-s3_direct_upload/#comment-93

A word of caution, I couldn't get the heroku code working as it would give me a invalid argument, as the file
was not the last element in post request. Do leave a comment if you get it working. An example response error,
not the one I encountered. 

	<?xml version="1.0" encoding="UTF-8"?>
	<Error>
	  <Code>NoSuchKey</Code>
	  <Message>The resource you requested does not exist</Message>
	  <Resource>/mybucket/myfoto.jpg</Resource> 
	  <RequestId>4442587FB7D0A2F9</RequestId>
	</Error>

Using figaro for setting evn variables so that need not expose aws_access_key_id, aws_secret_access_key and aws_bucket.
You can look at the following link for more information http://railsapps.github.io/rails-environment-variables.html

Amazon Bucket CORS setting 

	<CORSConfiguration>
	    <CORSRule>
	        <AllowedOrigin>http://localhost:3000</AllowedOrigin>
	        <AllowedMethod>GET</AllowedMethod>
	        <AllowedMethod>PUT</AllowedMethod>
	        <AllowedMethod>POST</AllowedMethod>
	        <MaxAgeSeconds>3000</MaxAgeSeconds>
	        <AllowedHeader>*</AllowedHeader>
	    </CORSRule>
	</CORSConfiguration>

References 

https://devcenter.heroku.com/articles/direct-to-s3-image-uploads-in-rails#debugging
http://blog.littleblimp.com/post/53942611764/direct-uploads-to-s3-with-rails-paperclip-and
http://railsapps.github.io/rails-environment-variables.html
