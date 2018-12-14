class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: {case_sensitivity: false}
end
