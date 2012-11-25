module NextPreviousLinks
  def next_link
    siblings = find_siblings(@item)
    if siblings.size == 1
      # There's only one picture in this gallery, so no need for
      # next and previous links.
      return
    end
    siblings.sort! { |a, b| a[:gallery_order] <=> b[:gallery_order] }
    next_index = siblings.index(@item) + 1
    if siblings[next_index].nil?
      # If we're on the last page of the gallery, "next" will wrap
      # around to the first.
      next_index = 0
    end
    link_to("Next", siblings[next_index]) + ": #{siblings[next_index][:title]}"
  end
  
  def previous_link
    siblings = find_siblings(@item)
    if siblings.size == 1
      # There's only one picture in this gallery, so no need for
      # next and previous links.
      return
    end
    siblings.sort! { |a, b| a[:gallery_order] <=> b[:gallery_order] }
    previous_index = siblings.index(@item) - 1
    link_to("Previous", siblings[previous_index]) + ": #{siblings[previous_index][:title]}"
  end
end