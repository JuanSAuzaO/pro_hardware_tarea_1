class Api::V1::ProductsController < ApplicationController

  def index
    products = Product.paginate(page: params[:page] , per_page: 20)
    render json: { success: true, products: }
  end

  def create
    product = Product.new(product_params)
    if product.save
      render json: {
        status: { code: 200, message: 'Product created succesully!' },
        data: product
      }
    else
      render json: {
        message: "Product couldn't be created succesfully.", errors: product.errors
      }, status: :unprocessable_entity
    end
  end

  def show
    product = Product.find(params[:id])
    render json: { success: true, product: }
  end

  def update
    product = Product.find(params[:id])
    if product.update(product_params)
      render json: {
        status: { code: 200, message: 'Product updated succesully!' },
        data: product
      }
    else
      render json: {
        message: "Product couldn't be updated succesfully.", errors: product.errors
      }, status: :unprocessable_entity
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    render json: { success: true, message: 'Product destroyed successfully' }
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price_cents)
  end
end