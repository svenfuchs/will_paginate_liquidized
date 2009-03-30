module WillPaginate::Liquidized
  module ViewHelpers
    include WillPaginate::ViewHelpers
    alias :will_paginate_without_liquid :will_paginate
    
    def will_paginate (pager, path_info, options = {})
      return '' if path_info.nil?
      @path_info = path_info
      will_paginate_without_liquid(pager, options)
    end

    def page_link_or_span(page, span_class = nil, text = page.to_s)
      unless page
        content_tag :span, text, :class => span_class
      else        
        content_tag :a, text, :href => path_for(@path_info, page)
      end
    end     
    
    def path_for(path_info, page)      
      path = []
      path << path_info[:path] unless path_info[:path].blank? 
      path << 'page' << page   unless page == 1
      '/' + path.join('/')
    end
  end
end