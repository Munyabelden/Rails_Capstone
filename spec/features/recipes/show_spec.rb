require 'rails_helper'
require 'capybara/rails'

RSpec.feature 'Recipe Show', type: :feature do
  include Devise::Test::IntegrationHelpers

  let!(:user) { User.create(name: 'John Doe') }
  let!(:food) { Food.create(name: 'Ingredient 1') }
  let!(:recipe) do
    Recipe.create(name: 'Pasta Carbonara', preparation_time: '00:15', cooking_time: '00:20',
                  description: 'A delicious pasta dish.', user:)
  end
  let!(:recipe_food) { RecipeFood.create(recipe:, food:) }

  scenario 'User views the recipe name and details' do
    sign_in user
    recipe.save
    visit recipe_path(recipe)

    expect(page).to have_selector('h2.recipe-name', text: recipe.name)
    expect(page).to have_content('Preparation time: 0 hours 15 minutes')
    expect(page).to have_content('Cooking time: 0 hours 20 minutes')
  end

  scenario "User sees the 'Add Ingredient' link and food table" do
    sign_in user
    recipe.save
    visit recipe_path(recipe)

    within('.recipe-details') do
      expect(page).to have_link('Add Ingredient', href: new_recipe_recipe_food_path(recipe_id: recipe.id))

      within('.food-table') do
        expect(page).to have_selector('th', text: 'Food')
        expect(page).to have_selector('th', text: 'Quantity')
        expect(page).to have_selector('th', text: 'Value')
        expect(page).to have_selector('th', text: 'Action')
      end
    end
  end
end
