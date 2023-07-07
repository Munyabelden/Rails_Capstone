class Recipe < ApplicationRecord
  belongs_to :user

  has_many :recipe_foods
  has_many :foods, through: :recipe_foods, dependent: :destroy

  validates :name, presence: true
  validates :preparation_time, format: { with: /\A\d{1,2}:\d{2}\z/, message: 'should be in the format HH:MM' }
  validates :cooking_time, format: { with: /\A\d{1,2}:\d{2}\z/, message: 'should be in the format HH:MM' }
  validates :description, presence: true
end
