require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  before :each do
    @user = User.create(name: 'Grabrielle', email: 'gabrielle@test.com', password: '123456789')
    @recipe = @user.recipes.create(name: 'La soupe au choux', preparation_time: '2 hours', cooking_time: '1 hour',
                                   description: 'La soupe au choux description')
    post user_session_path, params: { user: { email: @user.email, password: @user.password } }
  end

  describe 'GET #index' do
    before(:example) { get recipes_path }

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
      expect(response).to render_template('index')
    end

    it "should include 'La soupe au choux'" do
      expect(response.body).to include('La soupe au choux')
    end
  end

  describe 'GET #show' do
    before(:example) { get recipe_path(@recipe) }

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'show' template" do
      expect(response).to render_template('show')
    end

    it 'should render the recipe card' do
      expect(response.body).to include('La soupe au choux')
      expect(response.body).to include('2 hours')
      expect(response.body).to include('1 hour')
      expect(response.body).to include('Public')
    end
  end

  describe 'GET #new' do
    before(:example) { get new_recipe_path }

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'show' template" do
      expect(response).to render_template('new')
    end

    it 'should include "Create New Recipe"' do
      expect(response.body).to include('Create New Recipe')
    end
  end
end
