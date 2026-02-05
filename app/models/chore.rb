class Chore < ApplicationRecord
    belongs_to :children
    belongs_to :task
end
