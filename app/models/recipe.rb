class Recipe < ApplicationRecord
  belongs_to :user

  has_many :recipe_foods
  has_many :foods, through: :recipe_foods, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
end
