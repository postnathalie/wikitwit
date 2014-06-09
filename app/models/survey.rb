class Survey < ActiveRecord::Base
	belongs_to :user
	has_many :questions, dependent: :destroy
	validates :user_id, presence: true
	default_scope -> { order('created_at DESC') }
  	accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
end
