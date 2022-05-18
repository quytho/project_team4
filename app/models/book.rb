class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :category
  belongs_to :publisher
  has_many :borrow_requets
  has_many :follows, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
  validates :name, presence: true
  validates :amount, presence: true
  accepts_nested_attributes_for :publisher, reject_if: :all_blank
  accepts_nested_attributes_for :author, reject_if: :all_blank
  scope :order_name, -> { order(name: :ASC) }
  scope :search_name, ->(name) { where("name LIKE ?", "%#{name}%") if name.present? }
  scope :search_author, ->(author_id) { where(author_id: author_id) if author_id.present? }
  scope :search_publisher, ->(publisher_id) { where(publisher_id: publisher_id) if publisher_id.present? }
  scope :search, lambda { |params|
                   search_name(params[:name])
                     .search_author(params[:author_id])
                     .search_publisher(params[:publisher_id])
                 }
  def self.to_xls(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |book|
        csv << book.attributes.values_at(*column_names)
      end
    end
  end
end
