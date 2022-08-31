class UpdatePublicDefaultToZeroRecipes < ActiveRecord::Migration[7.0]
  def change
    change_column_default :recipes, :public, 0
  end
end
