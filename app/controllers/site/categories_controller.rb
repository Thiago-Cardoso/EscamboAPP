class Site::CategoriesController < SiteController

    def show
        @categories = Category.order(:description)
        @category = Category.friendly.find(params[:id])
        #@ads = Ad.where_category(@category)
        @ads = Ad.by_category(@category, params[:page])
    end

end
