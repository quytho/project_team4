class Category < ActiveRecord::Base
  validates :name, presence: true
  has_many :books
  scope :search_name, ->(name) { where('LOWER(name) LIKE ?', "%#{name}%") if name.present? }
  scope :search, lambda { |params|
    search_name(params[:name])
  }
end
