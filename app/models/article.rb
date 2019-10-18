class Article < ApplicationRecord
  scope :available, -> { where(status: true) }
end
