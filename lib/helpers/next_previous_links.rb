module NextPreviousLinks
    def next_link
        siblings = find_siblings(@item)
        if siblings.size == 1
            # There's only one picture in this gallery, so no need for
            # next and previous links.
            return
        end
        next_index = siblings.index(@item) + 1
        if siblings[next_index].nil?
            # If we're on the last page of the gallery, "next" will wrap
            # around to the first.
            next_index = 0
        end
        return "Next: " + link_to(siblings[next_index][:title], siblings[next_index])
    end
  
    def previous_link
        siblings = find_siblings(@item)
        if siblings.size == 1
            # There's only one picture in this gallery, so no need for
            # next and previous links.
            return
        end
        previous_index = siblings.index(@item) - 1
        return "Previous: " + link_to(siblings[previous_index][:title], siblings[previous_index])
    end
end