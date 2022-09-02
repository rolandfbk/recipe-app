require 'rails_helper'

RSpec.describe 'RecipeFoods', type: :request do
  before :each do
    @user = User.create(name: 'Grabrielle', email: 'gabrielle@test.com', password: '123456789')
    @recipe = @user.recipes.create(name: 'La soupe au choux', preparation_time: '2 hours', cooking_time: '1 hour',
                                   description: 'La soupe au choux description')
    @food = @user.foods.create(name: 'Beef', measurement_unit: 'kg', price: 2, quantity: 3)
    @recipe_food = @recipe.recipe_foods.create(food_id: @food.id, quantity: 1)
    post user_session_path, params: { user: { email: @user.email, password: @user.password } }
  end

  describe 'GET #new' do
    before(:example) { get new_recipe_recipe_food_path(@recipe) }

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'show' template" do
      expect(response).to render_template('new')
    end

    it 'should include "Add ingredient"' do
      expect(response.body).to include('Add ingredient')
    end
  end

  describe 'GET #edit' do
    before(:example) { get edit_recipe_recipe_food_path(@recipe, @recipe_food) }

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('edit')
    end

    it "should include 'Edit ingredient'" do
      expect(response.body).to include('Edit ingredient')
    end
  end
end
