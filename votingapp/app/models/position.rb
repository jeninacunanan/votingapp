class Position < ActiveRecord::Base
	has_many :candidates

	validates :name, presence: :true, uniqueness: :true
end
