module Utilities
    
    # Takes an item as the parameter and returns an array of items located
    # in the same folder.
    def find_siblings (item)
        parent_identifier = item.identifier.sub(/[^\/]+\/$/, '')
        return @items.select { |e| e.identifier.include? parent_identifier }
    end
end