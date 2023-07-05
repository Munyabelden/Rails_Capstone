require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = User.new(name: "John Doe", email: "john@example.com", password: "password")
    expect(user).to be_valid
  end

  it "is not valid without a name" do
    user = User.new(email: "john@example.com", password: "password")
    expect(user).not_to be_valid
  end

  it "has many foods" do
    user = User.new(name: "John Doe", email: "john@example.com", password: "password")
    expect(user.foods).to be_empty
  end

  it "has many recipes" do
    user = User.new(name: "John Doe", email: "john@example.com", password: "password")
    expect(user.recipes).to be_empty
  end
end
  