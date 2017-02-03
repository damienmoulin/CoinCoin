class Article < ApplicationRecord
  has_attached_file :image, styles: { medium: "200x200>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  belongs_to :categorie
  belongs_to :user
  has_many :comments
end
