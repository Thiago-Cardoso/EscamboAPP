class Backoffice::CategoriesController::CategoryService #poro isola cada classe colocando em um serviço
    attr_accessor :category #declaro a variavel como um atributo da classe

    def self.create(params_category)
        @category = Category.new(params_category)
        if @category.valid? #
            @category.save!
        end

        @category
    end
end