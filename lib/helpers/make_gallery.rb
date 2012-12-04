require 'image_size'
require 'pathname'

module MakeGallery
  def make_gallery
    photo_div = String.new
    images_folder = Pathname.new(@item.rep_named(:default).raw_path).parent + "Images"
    gallery_pages = @items.select { |e| e.identifier.include? @item.identifier + "Pages/" }
    gallery_pages.sort! { |a, b| a[:gallery_order] <=> b[:gallery_order] }
    gallery_path = Pathname.new(@item.path)
    gallery_pages.each do |photo|
      img_tag = image_tag(photo[:photoID] + "-Thumb.jpg",
                          "Thumbnail of " + photo[:title])
            
      # Assemble the HTML to return
      photo_div << %(<div class="thumbnail">\n)
      photo_div << %(<a href="#{relative_path_to(photo)}">)
      photo_div << %(#{img_tag})
      photo_div << %(</a><br />\n#{photo[:title]}\n)
      photo_div << %(</div>\n\n)
    end
    photo_div
  end
end