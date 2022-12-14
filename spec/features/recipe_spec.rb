require 'rails_helper'

RSpec.describe 'Recipe page test', type: :feature do
  describe 'index page' do
    before :each do
      @user = User.create(name: 'Grabrielle', email: 'gabrielle@test.com', password: '123456789')
      @recipe = @user.recipes.create(name: 'La soupe au choux', preparation_time: '2 hours', cooking_time: '1 hour',
                                     description: 'La soupe au choux description')

      visit new_user_session_path
      fill_in 'Email', with: 'gabrielle@test.com'
      fill_in 'Password', with: '123456789'
      click_on 'Log in'
    end

    it 'check recipes#index path' do
      visit recipes_path
      expect(current_path).to eq(recipes_path)
      expect(page).to have_text('Add recipe')
    end

    it 'Should display all user recipe details' do
      visit recipes_path
      expect(page).to have_content('La soupe au choux')
      expect(page).to have_content('REMOVE')
      expect(page).to have_content('La soupe au choux description')
    end

    it "Should navigate to recipe's new page" do
      visit recipes_path
      click_link 'Add recipe'
      expect(current_path).to eq(new_recipe_path)
    end
  end

  describe 'show page' do
    before :each do
      @user = User.create(name: 'Grabrielle', email: 'gabrielle@test.com', password: '123456789')
      @recipe = @user.recipes.create(name: 'La soupe au choux', preparation_time: '2 hours', cooking_time: '1 hour',
                                     description: 'La soupe au choux description')

      visit new_user_session_path
      fill_in 'Email', with: 'gabrielle@test.com'
      fill_in 'Password', with: '123456789'
      click_on 'Log in'
    end

    it 'check recipes#show path' do
      visit "/recipes/#{@recipe.id}"
      expect(current_path).to eq("/recipes/#{@recipe.id}")
      expect(page).to have_text('La soupe au choux')
    end

    it 'Should display all user recipe details' do
      visit "/recipes/#{@recipe.id}"
      expect(page).to have_content('La soupe au choux')
      expect(page).to have_content('Preparation time')
      expect(page).to have_content('2 hours')
      expect(page).to have_content('Cooking time')
      expect(page).to have_content('1 hour')
      expect(page).to have_content('Public')
      expect(page).to have_content('La soupe au choux description')
    end

    it "Should navigate to recipe food's new page" do
      visit "/recipes/#{@recipe.id}"
      click_link 'Add ingredient'
      expect(current_path).to eq("/recipes/#{@recipe.id}/recipe_foods/new")
    end
  end
end
