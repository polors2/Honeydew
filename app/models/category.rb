class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: {case_sensitivity: false}
  validates :description, presence: true
  validates :category_id, presence: true
end
