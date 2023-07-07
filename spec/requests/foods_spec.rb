require 'rails_helper'

RSpec.describe FoodsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password') }
  let(:food1) { Food.create(name: 'Cheese', price: '5.99', user:) }
  let(:food2) { Food.create(name: 'Bread', price: '5.99', user:) }

  describe 'GET #index' do
    it 'assigns the user foods to @foods' do
      sign_in user

      get :index
      expect(assigns(:foods)).to eq([food2, food1])
    end

    it 'renders the index template' do
      sign_in user

      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'POST #create' do
    it 'creates a new food for the current user' do
      sign_in user

      expect do
        post :create, params: { food: { name: 'New Food', measurement_unit: 'Piece', price: 10.0, quantity: 5 } }
      end.to change(user.foods, :count).by(1)

      expect(response).to redirect_to(foods_path)
      expect(flash[:notice]).to eq('Food created successfully')
    end

    it 'renders the new template if the food is not saved' do
      sign_in user

      expect do
        post :create, params: { food: { name: '', measurement_unit: 'Piece', price: 10.0, quantity: 5 } }
      end.not_to change(user.foods, :count)

      expect(response).to render_template(:new)
    end
  end
end
