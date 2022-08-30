class FoodsController < ApplicationController
  def index
    @foods = current_user.foods
  end

  def new
  end

  def create
    @food = current_user.foods.create(food_params)
    
    puts @current_user
    if @food.save
      redirect_to food_path, notice: 'New post created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
