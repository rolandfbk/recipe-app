require 'rails_helper'

RSpec.describe 'Public recipe page test', type: :feature do
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

    it 'check public_recipes#index path' do
      visit public_recipes_path
      expect(current_path).to eq(public_recipes_path)
      expect(page).to have_text('List of public repices')
    end
  end
end
