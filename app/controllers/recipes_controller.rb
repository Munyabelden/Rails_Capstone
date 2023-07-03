class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: [:show, :destroy]
  
  def index
    @public_recipes = Recipe.where(public: true).order(created_at: :desc)
  end  

  def show
    @current_user = current_user
    @recipes = current_user.recipes
  end

  def destroy
    if @recipe.user == current_user
      @recipe.destroy
      redirect_to recipes_path, notice: 'Recipe was successfully deleted.'
    else
      redirect_to @recipe, alert: 'You are not authorized to delete this recipe.'
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
  