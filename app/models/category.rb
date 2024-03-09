class Category < ApplicationRecord
    def self.get_children(parent_id)
        Category.where(parent_id:parent_id, generations:1)
    end

    def self.get_parent(child_id)
        Category.find_by(child_id:child_id, generations:1)
    end
=begin
=end
end
