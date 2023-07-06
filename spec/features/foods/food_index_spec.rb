require 'rails_helper'
require 'capybara/rails'

RSpec.feature 'User Recipes', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password') }

  before do
    Recipe.create(name: 'Pasta Carbonara', preparation_time: '00:15', cooking_time: '00:20',
                  description: 'A delicious pasta dish.', user:)
    Recipe.create(name: 'Banana bread', preparation_time: '00:15', cooking_time: '00:20',
                  description: 'A delicious bread dish.', user:)
  end

  scenario "User views the list of user's recipes" do
    sign_in user
    visit recipes_path

    expect(page).to have_selector('h1.title', text: "#{user.name}'s Recipes")
    expect(page).to have_selector('.recipe-list')
  end

  scenario 'User sees the correct number of recipes' do
    sign_in user
    visit recipes_path

    expect(page).to have_selector('.recipe', count: 2)
  end

  scenario 'User sees the recipe names and descriptions' do
    sign_in user
    visit recipes_path

    expect(page).to have_content('Pasta Carbonara')
    expect(page).to have_content('A delicious pasta dish.')
    expect(page).to have_content('Banana bread')
    expect(page).to have_content('A delicious bread dish.')
  end

  scenario 'User sees the delete buttons' do
    sign_in user
    visit recipes_path

    expect(page).to have_selector('.delete-button', count: 2)
  end

  scenario "User sees the 'Create New Recipe' link" do
    sign_in user
    visit recipes_path

    expect(page).to have_link('Create New Recipe', href: new_recipe_path)
  end
end
