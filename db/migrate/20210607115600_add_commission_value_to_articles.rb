class AddCommissionValueToArticles < ActiveRecord::Migration[6.0]
  def change
  	add_column :articles, :commission_value, :jsonb
  end
end
