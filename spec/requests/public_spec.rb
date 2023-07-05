require 'rails_helper'

RSpec.describe PublicController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe 'GET #index' do
    it 'assigns public recipes to @public_recipes' do
      public_recipe1 = create(:recipe, public: true)
      public_recipe2 = create(:recipe, public: true)
      private_recipe = create(:recipe, public: false)

      get :index

      expect(assigns(:public_recipes)).to eq([public_recipe2, public_recipe1])
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template('index')
    end
  end
end
