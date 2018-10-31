# require 'pry'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do 
    erb :new
  end

  post '/recipes' do 
    name = params[:name]
    ingredients = params[:ingredients]
    cook_time = params[:cook_time]

    recipe = Recipe.create(name: name, ingredients: ingredients, cook_time: cook_time)
    redirect "/recipes/#{recipe.id}"
  end

  get '/recipes/:id' do 
    recipe_id = params[:id]
    @recipe = Recipe.find_by_id(recipe_id)

    erb :show
  end

  get '/recipes/:id/edit' do 
    recipe_id = params[:id]
    @recipe = Recipe.find_by_id(recipe_id)
    erb :edit
  end

  delete '/recipes/:id/delete' do
    Recipe.destroy(params[:id])
    redirect "/recipes"
  end

  patch '/recipes/:id' do 
    recipe_id = params[:id]
    name = params[:name]
    ingredients = params[:ingredients]
    cook_time = params[:cook_time]
    @recipe = Recipe.find_by_id(recipe_id)
    @recipe.name = name
    @recipe.ingredients = ingredients
    @recipe.cook_time = cook_time
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
  end

end