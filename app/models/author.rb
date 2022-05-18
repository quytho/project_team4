class Author < ActiveRecord::Base
  has_many :books, dependent: :destroy
  validates :name, presence: true
  scope :order_name, -> { order(name: :ASC) }
  scope :search_name, ->(name) { where("LOWER(name) LIKE ?", "%#{name}%") if name.present? }
  scope :search, lambda { |params|
    search_name(params[:name])
  }
  def self.to_xls(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |author|
        csv << author.attributes.values_at(*column_names)
      end
    end
  end
end
