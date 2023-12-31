class RecipesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_recipe, only: %i[show destroy]

  def index
    @current_user = current_user
    @recipes = current_user.recipes
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = RecipeFood.includes(:recipe).where(recipe_id: @recipe.id)
  end

  def new
    @recipe = Recipe.includes(:user).new
  end

  def publicize
    @recipe = Recipe.find(params[:id])
    @recipe.public = !@recipe.public
    if @recipe.save
      redirect_to public_index_path, notice: 'Recipe public status has been updated.'
    else
      redirect_to @recipe, alert: 'Failed to update recipe.'
    end
  end

  def create
    @recipe = Recipe.create(recipe_params.merge(user_id: current_user.id))
    if @recipe.save
      redirect_to recipes_path, notice: 'New recipe was successfully created.'
    else
      render :new, alert: 'Error creating new recipe.'
    end
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
    @recipe = if params[:id] == 'public'
                nil
              else
                Recipe.find(params[:id])
              end
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :preparation_time, :cooking_time, :public)
  end
end
