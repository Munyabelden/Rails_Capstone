class GeneralShoppingListsController < ApplicationController
  def index
    @user = current_user
    @food = @user.foods.left_outer_joins(:recipe_foods).where(recipe_foods: { id: nil }).includes(:recipe_foods)
    @shopping_list = create_shopping_list
    @food_counts = @shopping_list.count
    @total_price = @shopping_list.sum { |item| item[:price] }
  end

  private

  def create_shopping_list
    shopping_list = []
    @user = current_user
    @recipes = @user.recipes.includes(recipe_foods: :food)

    @recipes.each do |recipe|
      recipe.recipe_foods.each do |recipe_food|
        food = recipe_food.food
        general_food = @food.find_by(name: food.name)

        next if general_food && general_food[:quantity] >= recipe_food.quantity

        quantity_needed = recipe_food.quantity - (general_food&.quantity || 0)

        shopping_list << { name: food.name, quantity: quantity_needed, measurement_unit: food.measurement_unit, price: food.price }
      end
    end

    shopping_list
  end
end
