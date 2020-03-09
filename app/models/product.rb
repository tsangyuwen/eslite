class Product < ApplicationRecord
  include AASM

  has_rich_text :desc

  validates_uniqueness_of :sku
  validates_presence_of :sku, :name, :origin_price, :selling_price

  enum status: {
    on_shelve: "on_shelve",
    off_shelve: "off_shelve",
    purchasing: "purchasing"
  }

  aasm column: :status, enum: true do
    state :purchasing, initial: true
    state :off_shelve, :on_shelve

    event :put_on_shelve do
      transitions from: :purchasing, to: :on_shelve
    end

    event :pull_off_shelve do
      transitions from: :on_shelve, to: :off_shelve
    end
  end
end