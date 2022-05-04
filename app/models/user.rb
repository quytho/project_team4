class User < ActiveRecord::Base
  has_many :borrow_requets
  has_many :follows
  has_many :likes
  has_many :comments
  has_many :rates

  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest

  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
  scope :order_name, -> { order(is_admin: :DESC)}
  scope :search_name, ->(name) { where("LOWER(name) LIKE ?", "%#{name}%") if name.present? }
  scope :search_role, ->(is_admin) { where(is_admin: is_admin) if is_admin.present? }
  scope :search, lambda { |params|
    search_name(params[:name])
    # .search_role(params[:is_admin])
  }
  def self.to_xls(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |student|
        csv << student.attributes.values_at(*column_names)
      end
    end
  end

end
