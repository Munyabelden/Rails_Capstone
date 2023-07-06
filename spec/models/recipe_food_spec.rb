require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:food) { Food.create(name: 'Cheese') }
  let(:recipe) { Recipe.create(name: 'Pizza') }

  it 'is valid with valid attributes' do
    recipe_food = RecipeFood.new(food:, recipe:, quantity: 2)
    expect(recipe_food).to be_valid
  end

  it 'is not valid without a quantity' do
    recipe_food = RecipeFood.new(food:, recipe:)
    expect(recipe_food).not_to be_valid
  end

  it 'belongs to a food' do
    recipe_food = RecipeFood.new(recipe:, quantity: 2)
    recipe_food.food = food
    expect(recipe_food.food).to eq(food)
  end

  it 'belongs to a recipe' do
    recipe_food = RecipeFood.new(food:, quantity: 2)
    recipe_food.recipe = recipe
    expect(recipe_food.recipe).to eq(recipe)
  end
end
