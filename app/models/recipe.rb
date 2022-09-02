class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy

  def total_food
    recipe_foods.count
  end

  def total_price
    all_recipes = recipe_foods.includes(:food)
    total = 0
    all_recipes.each { |re| total += re.food.price }
    total
  end

  validates :name, presence: true, length: { maximum: 250 }
  validates :preparation_time, presence: true, length: { maximum: 250 }
  validates :cooking_time, presence: true, length: { maximum: 250 }
  validates :description, presence: true, length: { maximum: 500 }
end
