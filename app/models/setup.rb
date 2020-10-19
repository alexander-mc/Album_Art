class Setup < ActiveRecord::Base
    belongs_to :user

    validates :rows, numericality: { only_integer: true, greater_than: 0, message: "must be an integer greater than 0" }
    validates :columns, numericality: { only_integer: true, greater_than: 0, message: "must be an integer greater than 0" }
end