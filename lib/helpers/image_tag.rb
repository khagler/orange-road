module ImageTagMaker    
    require 'image_size'
    require 'pathname'

    def image_tag
        photo = @item[:photoID] + ".jpg"
        gallery_page = Pathname.new(@item.path)
        # I'm using this method of finding the path to the image file instead
        # of trying to get the parent of the parent of "@item" because that
        # approach didn't work, and I got tired of struggling with trying to
        # figure out why.
        photo_path = gallery_page.parent.parent + "Images" + photo
        alt_text = "Photo of " + @item[:title]
        img_src = photo_path.relative_path_from(gallery_page)
        gallery_full_path = Pathname.new(@item.rep_named(:default).raw_path)
        photo_size = ImageSize.path(gallery_full_path.parent.parent + "Images" + photo)
        return "<img height=\"#{photo_size.height}\" alt=\"#{alt_text}\" src=\"#{img_src}\" width=\"#{photo_size.width}\" border=\"0\" />"
    end
end