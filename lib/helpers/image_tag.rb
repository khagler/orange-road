require 'image_size'
require 'pathname'

module ImageTagMaker
  
  # The +image_tag+ method creates an HTML img tag.
  # === Parameters
  # * _photo_ = The file name of the photo
  # * _alt_text_ = (Optional) The string to use as the images alt text
  # * _attributes_ = (Optional) Any HTML attributes (e.g. 'class=') to include
  #   in the img tag.
  def image_tag(photo, alt_text='', attributes='')
    images = 'Images'
    # The path within the nanoc site. Its root is the "content" folder.
    item_path = Pathname.new(@item.path)
    # The full path on the file system.
    item_full_path = Pathname.new(@item.rep_named(:default).raw_path).realpath

    # Figuring out where exactly the photo is is complicated by the need to
    # maintain backward compatibility with the existing site structure, where
    # images can be in any of three different places:
    # 1. In '../Images/' for full-size photos on photo pages
    # 2. In './Images/' for thumbnails on gallery indices
    # 3. In '/img/' for everything else.
    if (photo_full_path = item_full_path.parent.parent.join(images, photo)).exist?
      photo_path = item_path.parent.join(images, photo)
    elsif (photo_full_path = item_full_path.parent.join(images, photo)).exist?
      photo_path = item_path.join(images, photo)
    else
      photo_path = Pathname.new('/img').join(photo)
      # We have to get the path to '/img' this way because the directory has
      # no index.html, so as far as nanoc is concerned '/img/' doesn't exist.
      photo_full_path = Pathname.new(@items.find { |e| e.identifier == '/' } \
        .rep_named(:default).raw_path).parent.join('img', photo)
    end
    img_src = photo_path.relative_path_from(item_path)    
    photo_size = ImageSize.path(photo_full_path)
    %(<img height="#{photo_size.height}" alt="#{alt_text}" src="#{img_src}" width="#{photo_size.width}" border="0" #{attributes} />)
  end
end