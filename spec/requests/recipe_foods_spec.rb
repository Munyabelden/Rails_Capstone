require 'rails_helper'

RSpec.describe RecipeFoodsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { User.create(name: "John Doe", email: "john@example.com", password: "password") }
  let(:recipe) { Recipe.create(name: "Pasta Carbonara", preparation_time: "00:15", cooking_time: "00:20", description: "A delicious pasta dish.", user: user) }
  let(:food) { Food.create(name: "Cheese", price: "5.99", user: user) }

  describe "GET #new" do
    it "assigns the recipe, foods, and a new recipe_food" do
      sign_in user
      get :new, params: { recipe_id: recipe.id }
      expect(assigns(:recipe)).to eq(recipe)
      expect(assigns(:foods)).to eq(user.foods)
      expect(assigns(:recipe_food)).to be_a_new(RecipeFood)
    end
  end

  describe "POST #create" do
    it "creates a new recipe_food" do
      sign_in user
      expect {
        post :create, params: { recipe_id: recipe.id, recipe_food: { quantity: 2, food_id: food.id } }
      }.to change(RecipeFood, :count).by(1)
      expect(response).to redirect_to(recipe_path(recipe))
      expect(flash[:notice]).to eq("A new ingredient has been added successfully")
    end

    it "redirects with an alert if the recipe already has the ingredient" do
      RecipeFood.create(recipe: recipe, food: food, quantity: 1)
      sign_in user
      post :create, params: { recipe_id: recipe.id, recipe_food: { quantity: 2, food_id: food.id } }
      expect(response).to redirect_to(recipe_path(recipe))
      expect(flash[:alert]).to eq("Recipe already has this ingredient. Use Modify button")
    end

    it "renders the new template with an alert if save fails" do
      sign_in user
      allow_any_instance_of(RecipeFood).to receive(:save).and_return(false)
      post :create, params: { recipe_id: recipe.id, recipe_food: { quantity: 2, food_id: food.id } }
      expect(response).to render_template(:new)
      expect(flash[:alert]).to eq("Something went wrong, Try again!")
    end
  end
end
