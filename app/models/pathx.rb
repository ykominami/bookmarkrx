class Pathx < ApplicationRecord
    has_many :bookmarks

    validates :path, presence: true
    # validates :age, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :last_item, presence: true
  
    def self.ransackable_attributes(auth_object = nil)
        ["idx", "created_at", "id", "path", "last_item", "updated_at"]
    end
 
    def self.ransackable_associations(auth_object = nil)
        ["bookmarks"]
    end
    
    def level
        unless @level_value
            @level_value =  if path
                                path.split('/').size
                            else
                                0
                            end
        end
        @level_value
    end

    def path2(path)
        if path
            array = path.split('/')
            array.shift
            array.join('/')
        else
            nil
        end
    end
end
