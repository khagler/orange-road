require 'image_size'
require 'pathname'

module MakeGallery
    def make_gallery
        photo_div = String.new
        images_folder = Pathname.new(@item.rep_named(:default).raw_path).parent + "Images"
        gallery_pages = @items.select { |e| e.identifier.include? @item.identifier + "Pages/" }
        gallery_path = Pathname.new(@item.path)
        gallery_pages.each do |photo|
            # Find the thumbnail for this photo.
            thumbnail = photo[:photoID] + "-Thumb.jpg"
            thumbnail_path = gallery_path + "Images" + thumbnail
            alt_text = "Thumbnail of " + photo[:title]
            img_src = thumbnail_path.relative_path_from(gallery_path)
            thumbnail_size = ImageSize.path(images_folder + thumbnail)
            
            # Assemble the HTML to return
            photo_div << "<div class=\"thumbnail\">\n"
            photo_div << "<a href=\"#{relative_path_to(photo)}\">"
            photo_div << "<img height=\"#{thumbnail_size.height}\" alt=\"#{alt_text}\""
            photo_div << "src=\"#{img_src}\" width=\"#{thumbnail_size.width}\" border=\"0\" />"
            photo_div << "</a><br />\n#{photo[:title]}\n"
            photo_div << "</div>\n\n"
        end
        return photo_div
    end
    
end