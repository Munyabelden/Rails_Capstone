require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { User.create(name: "John Doe", email: "john@example.com", password: "password") }
  let(:recipe) { Recipe.create(name: "Pasta Carbonara", description: "A delicious pasta dish.", preparation_time: "00:15", cooking_time: "00:20", public: true, user: user) }

  describe "GET #index" do
    before { sign_in user }

    it "assigns the current user's recipes to @recipes" do
      get :index
      expect(assigns(:recipes)).to eq([recipe])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "assigns the requested recipe to @recipe" do
      get :show, params: { id: recipe.id }
      expect(assigns(:recipe)).to eq(recipe)
    end

    it "renders the show template" do
      sign_in user
      get :show, params: { id: recipe.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    before { sign_in user }

    it "assigns a new recipe to @recipe" do
      get :new
      expect(assigns(:recipe)).to be_a_new(Recipe)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end
end
