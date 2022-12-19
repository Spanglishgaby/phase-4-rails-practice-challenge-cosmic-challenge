class PlanetsController < ApplicationController
     #GET
     def index
        planets= Planet.all 
        render json: planets
    end
end
