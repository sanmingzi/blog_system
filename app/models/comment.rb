class Comment < ApplicationRecord
  belongs_to :article

  validates :commenter, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 5 }

  scope :available, -> { where(status: true) }

  def destroy
    self.status = false
    self.save(validate: false)
  end
end
