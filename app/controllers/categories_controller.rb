class CategoriesController < ApplicationController
	before_action :require_admin, except: [:index, :show]

	def show
		@category = Category.find(params[:id])
	end	

	def create
		@category = Category.new(category_params)
		if @category.save
			flash[:notice] = "Category Successfully created"
			redirect_to @category
		else
			render 'new'
		end
	end

	def edit
		@category = Category.find(params[:id])
	end

	def update
	   @category = Category.find(params[:id])
		if @category.update(category_params)
			flash[:notice] = "Successfully updated the category"
			redirect_to category_path
		else
			render 'update'
		end
	end

	def index
		@categories = Category.paginate(page: params[:page], per_page: 5).order(created_at: :desc)
	end

	def new
		@category = Category.new
	end

	private

	def category_params
		params.require(:category).permit(:name)
	end

	def require_admin
		unless logged_in? && current_user.admin?
			flash[:alert] = "You do not have access to do these changes"
			redirect_to categories_path
		end
	end
end