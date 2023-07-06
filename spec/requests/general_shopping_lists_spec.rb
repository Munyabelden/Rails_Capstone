require 'rails_helper'

RSpec.describe GeneralShoppingListsController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe 'GET #index' do
    let(:user) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password') }
    let!(:food1) { Food.create(name: 'Cheese', price: '5.99', user:) }
    let!(:food2) { Food.create(name: 'Bread', price: '5.99', user:) }

    before do
      sign_in(user)
      get :index
    end

    it "assigns the user's foods without recipe_foods to @food" do
      expect(assigns(:food)).to include(food1)
      expect(assigns(:food)).to include(food2)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end
  end
end
