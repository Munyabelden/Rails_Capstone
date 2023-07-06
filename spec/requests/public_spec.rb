require 'rails_helper'

RSpec.describe PublicController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password') }
  let!(:recipe) do
    Recipe.create(name: 'Pasta Carbonara', preparation_time: '00:15', cooking_time: '00:20',
                  description: 'A delicious pasta dish.', user:, public: true)
  end
  let!(:recipe1) do
    Recipe.create(name: 'Pasta Carbonara', preparation_time: '00:15', cooking_time: '00:20',
                  description: 'A delicious pasta dish.', user:, public: true)
  end
  let!(:recipe2) do
    Recipe.create(name: 'Pasta Carbonara', preparation_time: '00:15', cooking_time: '00:20',
                  description: 'A delicious pasta dish.', user:, public: true)
  end

  describe 'GET #index' do
    it 'renders the index template' do
      sign_in user
      get :index
      expect(response).to render_template('index')
    end

    it 'assigns public recipes to @public_recipes' do
      sign_in user
      get :index
      expect(assigns(:public_recipes)).to match_array([recipe, recipe1, recipe2])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested recipe to @recipe' do
      sign_in user
      get :show, params: { id: recipe.id }
      expect(assigns(:recipe)).to eq(recipe)
    end
  end
end
