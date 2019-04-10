class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if params[:pet][:owner_id] == nil
      @owner = Owner.create(name: params["owner"]["name"])
      @pet.owner = @owner
    end
  #  binding.pry
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    ##### bug fix
    #binding.pry
    #if !params[:pet].keys.include?("owner_id")
    #  params[:pet]["owner_id"] = []
    #end
    #####
#binding.pry
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"]);binding.pry
    if !params["owner"]["name"] == ""
      @owner = Owner.create(name: params["owner"]["name"])
      @pet.owner = @owner
      @pet.update(owner_id: @owner.id)
    end
    redirect to "pets/#{@pet.id}"
  end
end
