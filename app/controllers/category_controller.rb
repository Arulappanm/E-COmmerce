class CategoryController < ApplicationController
  before_action :authenticate_user!

  def index
  	@products = Product.all
  end

  def pre_seller
    @product = Product.new
  end
  
  def show
    @products = Product.all
  end

  def new_product
    @product = Product.new
  end

  def create_product
    @product = Product.new(product_params)

    if @product.save
      redirect_to root_path, notice: 'Product successfully added!'
    else
      redirect_to root_path, alert: 'Failed to add product!'
    end
  end

  def purchase_product
  end

  def add_to_cart_product
    product = Product.find(params[:id])
    quantity = 1

    # Check if the product is already in the user's cart
    cart_item = current_user.cart_items.find_by(product_id: product.id)

    if cart_item
      # If the product is in the cart, update the quantity
      cart_item.update(quantity: cart_item.quantity + quantity)
    else
      # If the product is not in the cart, create a new cart item
      current_user.cart_items.create(product_id: product.id, quantity: quantity)
    end

    redirect_to root_path, notice: 'Product added to cart!'
  end

  def search
    @products = Product.where("product_name LIKE ?", "%#{params[:query]}%")
    render :index
  end

  def cart_show
    @cart_items = current_user.cart_items.includes(:product)
    @cart_total = calculate_cart_total(@cart_items)
  end


private

  def product_params
    params.require(:product).permit(:product_name, :product_description, :product_price, :product_image)
  end

  def calculate_cart_total(cart_items)
    cart_items.sum { |item| item.quantity * item.product.product_price }
  end
end
