class ApplicationController < Sinatra::Base

  get '/games' do
    # get all the games from the database
    # return a JSON response with an array of all the game data
    
    set :default_content_type, 'application/json'
    #need to do this, bc by default Sinatra sets as text/html

    # games = Game.all
    games = Game.all.order(:title).limit(10)
    games.to_json
  end

  get '/games/:id' do
    game = Game.find(params[:id])

    # include associated reviews in the JSON response
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end
end