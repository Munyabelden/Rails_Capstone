require 'rails_helper'

RSpec.describe PublicController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { User.create(name: "John Doe", email: "john@example.com", password: "password") }
  let(:recipe) { Recipe.create(name: "Pasta Carbonara", preparation_time: "00:15", cooking_time: "00:20", description: "A delicious pasta dish.", user: user, public: true) }
  let(:recipe1) { Recipe.create(name: "Pasta Carbonara", preparation_time: "00:15", cooking_time: "00:20", description: "A delicious pasta dish.", user: user, public: true) }
  let(:recipe2) { Recipe.create(name: "Pasta Carbonara", preparation_time: "00:15", cooking_time: "00:20", description: "A delicious pasta dish.", user: user, public: true) }

  describe 'GET #index' do

    it 'renders the index template' do
      sign_in user
      get :index

      expect(response).to render_template('index')
    end
  end
end
