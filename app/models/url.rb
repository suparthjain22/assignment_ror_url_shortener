class Url < ApplicationRecord
  validates :name, format: { with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix, message: 'needs to be a valid URL' }

  before_save :set_slug

  def shortened
    "http://localhost:3000/r?#{set_slug}"
  end

  private

  def set_slug
    SecureRandom.alphanumeric(5) if slug.nil?
  end
end