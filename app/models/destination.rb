class Destination < ApplicationRecord
    has_many :pins
    has_many :users, through: :pins
end
