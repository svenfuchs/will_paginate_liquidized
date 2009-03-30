module WillPaginate::Liquidized
  Collection.class_eval do 
    def to_liquid
      WillPaginate::CollectionDrop.new self    
    end
    
    def collect(&block)    
      dup.replace super.collect(&block)
    end
  end  
  
  class CollectionDrop < Liquid::Drop
    attr_reader :source
  
    def initialize(source)
      @source = source
    end
    
    def [](*args)
      return @source[*args]
    end
    
    def method_missing(method, &block)
     allowed = [:current_page, :per_page, :total_entries, :page_count, 
                :offset, :previous_page, :next_page, :empty?, :length, 
                :sort_by]
     unless allowed.include? method
       super.method_missing method, &block
     else
        @source.send method, &block
      end
    end
  end
end