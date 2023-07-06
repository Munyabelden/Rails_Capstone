require 'rails_helper'
require 'capybara/rails'

RSpec.feature "Recipe Show", type: :feature do
  include Devise::Test::IntegrationHelpers

  let!(:user) { User.create(name: "John Doe") }
  let!(:food) { Food.create(name: "Ingredient 1") }
  let!(:recipe) { Recipe.create(name: "Pasta Carbonara", preparation_time: "00:15", cooking_time: "00:20", description: "A delicious pasta dish.", user: user) }
  let!(:recipe_food) { RecipeFood.create(recipe: recipe, food: food) }

  scenario "User views the recipe name and details" do
    sign_in user
    recipe.save # Save the recipe to assign a valid ID
    visit recipe_path(recipe)

    expect(page).to have_selector("h2.recipe-name", text: recipe.name)
    expect(page).to have_content("Preparation time: 00:15")
    expect(page).to have_content("Cooking time: 00:20")
  end

  scenario "User sees the 'Add Ingredient' link and food table" do
    sign_in user
    recipe.save # Save the recipe to assign a valid ID
    visit recipe_path(recipe)

    within(".recipe-details") do
      expect(page).to have_link("Add Ingredient", href: new_recipe_recipe_food_path(recipe_id: recipe.id))

      within(".food-table") do
        expect(page).to have_selector("th", text: "Food")
        expect(page).to have_selector("th", text: "Quantity")
        expect(page).to have_selector("th", text: "Value")
        expect(page).to have_selector("th", text: "Action")

        within("tbody") do
          expect(page).to have_selector("tr", count: 1)
          expect(page).to have_content("Ingredient 1")
        end
      end
    end
  end
end
