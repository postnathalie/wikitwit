class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	before_create :create_remember_token
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, length: { minimum: 6 }
	validates_confirmation_of :password
	has_attached_file :avatar, :styles => { :medium => "200x200>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  has_many :surveys, dependent: :destroy
  accepts_nested_attributes_for :surveys, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

  	def User.new_remember_token
  		SecureRandom.urlsafe_base64
  	end

  	def User.digest(token)
  		Digest::SHA1.hexdigest(token.to_s)
  	end

  	private

	  	def create_remember_token
	  		self.remember_token = User.digest(User.new_remember_token)
	  	end

end