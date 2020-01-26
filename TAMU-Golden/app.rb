
require "sinatra"
require 'data_mapper'
require 'stripe'
require 'sinatra/flash'

# need install dm-sqlite-adapter
# if on heroku, use Postgres database
# if not use sqlite3 database I gave you
if ENV['DATABASE_URL']
  DataMapper::setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
else
  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/app.db")
end

# class for the iteams added 
class Forms
  include DataMapper::Resource

  property :id, Serial
  property :Name, Text
  property :email, Text
  property :number, Text
  property :Animal, Text
  property :contained, Text
  property :state, Text
  property :scared, Text
  property :lat, Text
  property :lng, Text



#   #fill in the rest
end

DataMapper.finalize
Forms.auto_upgrade!

get "/about-us" do
  erb :about
end

get "/" do
  # @Form = Forms.all
  erb :index
end

get "/new-map" do
  erb :maps
end

#checks if the user has more than 25 items which is the limit.
#the params take a description, condition,zipcode, name. 
#the lower property turns the item name in lowercase, which is used in the search bars 
post "/" do
   
    Rescue = Forms.new

      Rescue.Name = params["name"]
      Rescue.email = params["email"]
      Rescue.number = params["phone"]
      Rescue.Animal = params["species"]
      Rescue.contained = params["contained"]
      Rescue.state = params["rescue-state"]
      Rescue.scared = params["scared-state"]
      Rescue.lat = params["lat"]
      Rescue.lng = params["lng"]

      
      Rescue.save


      erb :index

end

