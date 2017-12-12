class Ad < ActiveRecord::Base

   # Constants
  QTT_PER_PAGE = 6

  belongs_to :member
  belongs_to :category, counter_cache: true
    
  #validates
  validates :title, :description, :category, presence: true
  validates :picture, :finish_date, presence:true
  validates :price, numericality: {greater_than: 0} #preço é necessario ser numerico e > 0
 # Scopes
  scope :descending_order, ->(page) {
    order(created_at: :desc).page(page).per(QTT_PER_PAGE)
  }

  scope :to_the, ->(member) { where(member: member) }
 # scope :where_category, ->(id) { where(category: id) }

  scope :by_category, ->(id, page) { where(category: id).page(page).per(QTT_PER_PAGE) }

  scope :search, ->(q, page) {
   where("title LIKE ?", "%#{q}%").page(page).per(QTT_PER_PAGE) 
 }

  #paperclip
  has_attached_file :picture, styles: { large: "800X300#",medium: "320x150#", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
  #gem money-rails
  monetize :price_cents
  
end
