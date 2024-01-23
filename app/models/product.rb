class Product < ApplicationRecord
  has_many :cart_items
  
  has_attached_file :product_image, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :product_image, content_type: /\Aimage\/.*\z/
end
