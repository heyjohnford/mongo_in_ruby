require 'sinatra'
require 'mongo'
require 'json/ext'

include Mongo

# Connect to the database
connect = MongoClient.new('localhost', 27017)
set :mongo, connect
set :db, connect.db('test')
set :collection, settings.db['collection']

# Translate string ids to bson_id
def id(val)
  BSON::ObjectId.from_string(val)
end

# Find all records
get '/' do
  # Parenthesis on the find method are not needed.
  settings.collection.find().to_a.to_json
end

# New record - normally you would use a 'POST' method when interacting with a database
get '/insert' do
  settings.collection.insert({
    name: 'John Doe',
    profession: 'Geologist',
    location: 'United States',
    created_at: Time.now
  })
  'Record inserted.'
end

# Find single record - 'GET' method to read data
get '/find' do
  # Copy and paste the id from the index page '/' after inserting data to the database '/insert'
  settings.collection.find_one(:_id => id('id_string')).to_json
end

# Edit record - normally you would use a 'PUT' method to edit data in a database
get '/update' do
  settings.collection.update({:name => 'John Doe'}, {'$set' => {name: 'John Smith'}})
  'Record updated.'
end

# Remove record - normally you would use a 'DELETE' method to remove data from a database
get '/remove' do
  # Copy and paste in the id_string for the record you would like to remove from the index page '/'
  settings.collection.remove(:_id => id('id_string'))
  'Record removed.'
end

# Remove the entire collection
get '/drop' do
  settings.collection.remove()
  'Collection dropped.'
end
