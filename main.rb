
require 'sinatra'
require 'sqlite3'
require 'json'

database = SQLite3::Database.open("database/BabyNames.database")

get '/' do
  erb :Home
end

get '/baby' do
  if params['text']
    content_type :json
    if sanitize(params['text'])
      baby = database.execute("SELECT y1900,y1910,y1920,y1930,y1940,y1950,y1960,y1970,y1980,y1990,y2000
                             FROM BabyNames WHERE name=?", params['text'].capitalize)

      { result: params['text'].capitalize, baby: baby[0] }.to_json
    else
      { result: params['text'], error: 'Not a valid input'}.to_json
    end
  else
    halt(404)
  end
end

def sanitize(item)
  item =~ /^[[:alpha:]]+$/
end