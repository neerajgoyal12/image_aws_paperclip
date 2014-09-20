rails new image_aws_paperclip

cd image_aws_paperclip/

rails g scaffold user name:string

rails g scaffold photo ulr user:references

rake db:migrate

bundle install 

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
