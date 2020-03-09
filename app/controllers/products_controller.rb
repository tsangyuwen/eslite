class ProductsController < ApplicationController
    def index
        @products = Product.on_shelve.all
    end
end