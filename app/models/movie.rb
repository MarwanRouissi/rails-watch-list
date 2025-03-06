class Movie < ApplicationRecord
  has_many :bookmarks
  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true
  before_destroy :ensure_no_children

  private

  def ensure_no_children
    raise.ActiveRecord::InvalidForeignKey unless self.bookmarks
  end
end
