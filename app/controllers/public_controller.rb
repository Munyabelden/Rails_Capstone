class PublicController < ApplicationController
  def index
      @public_recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = RecipeFood.includes(:recipe).where(recipe_id: @recipe.id)
  end
end
