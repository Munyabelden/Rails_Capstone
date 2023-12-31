class RecipeFoodsController < ApplicationController
  def new
    @recipe = Recipe.find(params[:recipe_id])
    @foods = current_user.foods
    @recipe_food = RecipeFood.new
  end

  def create
    @recipe = Recipe.find_by(id: params[:recipe_id])
    food_ids = RecipeFood.where(recipe_id: @recipe.id).map(&:food_id)

    if food_ids.include?(recipe_food_params[:food_id].to_i)
      return redirect_to recipe_path(id: @recipe.id),
                         alert: 'Recipe already has this ingredient. Use Modify button'
    end

    @recipe_food = @recipe.recipe_foods.build(recipe_food_params)

    if @recipe_food.save
      redirect_to recipe_path(id: @recipe.id), notice: 'A new ingredient has been added successfully'
    else
      flash[:alert] = 'Something went wrong, Try again!'
      render :new
    end
  end

  def destroy
    @recipe_food = RecipeFood.includes(:recipe).find_by(id: params[:id])

    if @recipe_food.destroy
      redirect_to recipe_path(id: params[:recipe_id]), notice: 'The ingedrient was successfully removed.'
    else
      redirect_to recipe_path(id: params[:recipe_id]), notice: 'Error in removing the ingredient.'
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end
