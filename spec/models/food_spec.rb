require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password') }

  it 'is valid with valid attributes' do
    food = Food.new(name: 'Cheese', price: '$5.99')
    food.user = user
    expect(food).to be_valid
  end

  it 'is not valid without a name' do
    food = Food.new(price: '$5.99')
    food.user = user
    expect(food).not_to be_valid
  end

  it 'belongs to a user' do
    food = Food.new(name: 'Cheese', price: '$5.99')
    food.user = user
    expect(food.user).to eq(user)
  end

  it 'has many recipes' do
    food = Food.new(name: 'Cheese', price: '$5.99')
    food.user = user
    expect(food.recipes).to be_empty
  end
end
