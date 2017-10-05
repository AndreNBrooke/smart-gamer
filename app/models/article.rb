class Article < ApplicationRecord
	has_many :comments, dependent: :destroy
	default_scope { order(created_at: :desc) }

	def self.search(search)
    if search
      where("title ILIKE :search", search: "%#{search}%")
    end
  end
end
