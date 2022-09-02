class GeneralShoppingListController < ApplicationController


    def create
      @recipe = params[:recipe_id]
      p @recipe
      redirect_to general_shopping_list_index_path
    end

    def index
      user_foods = current_user.foods
      recipe_foods = @recipe.recipe_foods.includes(:food)
      @food_items_to_buy = []
      recipe_foods.each do |rfood|
          item = {
            :name => rfood.food.name,
            :quantity => (rfood.food.quantity < rfood.quantity)? rfood.quantity - rfood.food.quantity : rfood.quantity,
            :price => rfood.food.price
          }
        @food_items_to_buy << item
      end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:recipe)
  end
end