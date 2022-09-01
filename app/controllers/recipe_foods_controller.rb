class RecipeFoodsController < ApplicationController
  def new
    @recipe_food = RecipeFood.new
    @food_list = current_user.foods
    @recipe = Recipe.find(params[:recipe_id])
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)

    if @recipe_food.save
      redirect_to new_recipe_recipe_food_path(@recipe_food.recipe_id)
    else
      render :new
    end
  end

  def edit
    @recipe_food = RecipeFood.find(params[:id])
    @food_list = current_user.foods
    @recipe = Recipe.find(@recipe_food.recipe_id)
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.update(recipe_ingredient_params)
    redirect_to recipe_path(@recipe_food.recipe_id)
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy
    redirect_to recipe_path(@recipe_food.recipe_id)
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id, :recipe_id)
  end

  def recipe_ingredient_params
    params.require(:recipe_food).permit(:quantity, :food_id, :recipe_id)
  end
end
