module ImageTagMaker
    require 'image_size'
    
    def image_tag (item)
        images_parent = item.parent.parent.children.find
            { |i| i.identifier.grep(/Photos/) }
        photo = images_parent.children.find
            { |i| i.identifier.grep(item[:photoID]) }
        photo_size = ImageSize.path(photo.path())
        alt_text = "Photo of " + item[:title]
        img_src = photo.identifier.chop + '.' + photo[:extension]
        return '<img height="#{photo_size.height}" alt="#{alt_text}" src="#{img_src}" width="#{photo_size.width}" border="0" />'
    end
end