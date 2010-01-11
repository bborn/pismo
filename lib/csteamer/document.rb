require 'csteamer/internal_attributes'
require 'csteamer/external_attributes'

module CSteamer
  
  # CSteamer::Document represents a single HTML document within CSteamer
  class Document
    attr_reader :doc, :url
    
    include CSteamer::InternalAttributes
    
    def initialize(handle, url = nil)
      load(handle, url)
    end
    
    # An HTML representation of the document
    def html
      @doc.to_s
    end
    
    def load(handle, url = nil)
      @url = url if url
      @url = handle if handle =~ /^http/
      
      @html = if handle =~ /^http/
                open(handle).read
              elsif handle.is_a?(StringIO) || handle.is_a?(IO)
                handle.read
              else
                handle
              end
              
      @doc = Nokogiri::HTML(@html)
    end
  end
end