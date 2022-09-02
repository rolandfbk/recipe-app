require 'rails_helper'

RSpec.describe 'Shopping list page test', type: :feature do
  describe 'new page' do
    before :each do
      @user = User.create(name: 'Grabrielle', email: 'gabrielle@test.com', password: '123456789')
      @recipe = @user.recipes.create(name: 'La soupe au choux', preparation_time: '2 hours', cooking_time: '1 hour',
                                    description: 'La soupe au choux description')
      
      visit new_user_session_path
      fill_in 'Email', with: 'gabrielle@test.com'
      fill_in 'Password', with: '123456789'
      click_on 'Log in'
    end

    it 'check general_shopping_list#index path' do
      visit "/general_shopping_list?recipe=#{@recipe.id}"
      expect(current_path).to eq(general_shopping_list_index_path)
      expect(page).to have_text('Shopping List')
      expect(page).to have_text('List of foods')
    end
  end
end
