#Getting Started with MongoDB in Ruby

This is a quick reference guide on getting started with [mongoDB](http://www.mongodb.org/) using Ruby's [Sinatra](http://www.sinatrarb.com/).

##Connect to the mongo database
    # Connect to mongoDB
    connect = MongoClient.new("localhost", 27017)
    set :mongo, connect
    set :db, connect.db('test')
    set :collection, settings.db['collection']

##Insert a record
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

##Find all records in the collection
    # Find all records
    get '/' do
      # Parenthesis on the find method are not needed.
      settings.collection.find().to_a.to_json
    end

##Update a record
    # Edit record - normally you would use a 'PUT' method to edit data in a database
    get '/update' do
      settings.collection.update({:name => 'John Doe'}, {'$set' => {name: 'John Smith'}})
      'Record updated.'
    end

##Remove a record
    # Remove record - normally you would use a 'DELETE' method to remove data from a database
    get '/remove' do
      # Copy and paste in the id_string for the record you would like to remove from the index page '/'
      settings.collection.remove(:_id => BSON::ObjectId.from_string('id_string'))
      'Record removed.'
    end

##Remove a collection
    # Remove the entire collection
    get '/drop' do
      settings.collection.remove()
      'Collection dropped.'
    end
