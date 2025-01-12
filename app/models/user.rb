class User < ApplicationRecord
    has_many :cards
    
    validates :my_company, presence: true
    validates :my_name, presence: true
    validates :pass, presence: true
end
