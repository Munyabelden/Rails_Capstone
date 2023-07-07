require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password') }

  it 'is valid with valid attributes' do
    recipe = Recipe.new(
      name: 'Pasta Carbonara',
      preparation_time: '00:15',
      cooking_time: '00:20',
      description: 'A delicious pasta dish.'
    )
    recipe.user = user
    expect(recipe).to be_valid
  end

  it 'is not valid without a name' do
    recipe = Recipe.new(
      preparation_time: '00:15',
      cooking_time: '00:20',
      description: 'A delicious pasta dish.'
    )
    recipe.user = user
    expect(recipe).not_to be_valid
  end

  it 'is not valid without a valid preparation time format' do
    recipe = Recipe.new(
      name: 'Pasta Carbonara',
      preparation_time: '15 minutes',
      cooking_time: '00:20',
      description: 'A delicious pasta dish.'
    )
    recipe.user = user
    expect(recipe).not_to be_valid
    expect(recipe.errors[:preparation_time]).to include('should be in the format HH:MM')
  end

  it 'is not valid without a valid cooking time format' do
    recipe = Recipe.new(
      name: 'Pasta Carbonara',
      preparation_time: '00:15',
      cooking_time: '20 minutes',
      description: 'A delicious pasta dish.'
    )
    recipe.user = user
    expect(recipe).not_to be_valid
    expect(recipe.errors[:cooking_time]).to include('should be in the format HH:MM')
  end

  it 'is not valid without a description' do
    recipe = Recipe.new(
      name: 'Pasta Carbonara',
      preparation_time: '00:15',
      cooking_time: '00:20'
    )
    recipe.user = user
    expect(recipe).not_to be_valid
  end

  it 'belongs to a user' do
    recipe = Recipe.new(
      name: 'Pasta Carbonara',
      preparation_time: '00:15',
      cooking_time: '00:20',
      description: 'A delicious pasta dish.'
    )
    recipe.user = user
    expect(recipe.user).to eq(user)
  end

  it 'has many foods' do
    recipe = Recipe.new(
      name: 'Pasta Carbonara',
      preparation_time: '00:15',
      cooking_time: '00:20',
      description: 'A delicious pasta dish.'
    )
    recipe.user = user
    expect(recipe.foods).to be_empty
  end

  # Add more tests as needed
end
