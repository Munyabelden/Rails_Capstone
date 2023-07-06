require 'rails_helper'

RSpec.feature 'Public Recipes', type: :feature do
  before do
    # Assuming you have some test data set up
    @public_recipes = create_list(:public_recipe, 3)
  end

  scenario 'User views the list of public recipes' do
    visit '/public_recipes'

    within('.user-recipes') do
      expect(page).to have_selector('h1.title', text: 'Public Recipes')

      @public_recipes.each do |recipe|
        within('li.recipe') do
          within('div') do
            expect(page).to have_selector('h2 a', text: recipe.name)
            expect(page).to have_content("By #{recipe.user.name}")
          end

          expect(page).to have_selector('a', href: public_path(recipe))
          expect(page).to have_selector('p', text: "Total food items: #{recipe.recipe_foods.count}")
          expect(page).to have_selector('p',
                                        text: "Total Price: $#{RecipeFood.where(recipe_id: recipe.id).joins(:food).sum('recipe_foods.quantity * foods.price')}")
        end
      end
    end
  end
end
