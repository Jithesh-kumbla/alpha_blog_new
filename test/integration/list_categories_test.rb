require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest

	def setup
		@category = Category.create(name: "Sports")
		@category2 = Category.create(name: "Travels")
	end

	#test link which will redirect to specific path
	test "should show categories listing" do
		get categories_url
		assert_response :success
		assert_select "a[href=?]", category_path(@category), text: @category.name
		assert_select "a[href=?]", category_path(@category2), text: @category2.name
	end
end
