module Rtlize
  class RtlProcessor
    attr_reader :data

    def initialize(file, &block)
      @data = block.call
    end

    def render(context, locals, &block)
      allowed_extensions = ['sass', 'css', 'scss', 'erb']
      extension = context.pathname.basename.to_s.split('.').length > 1 ? context.pathname.basename.to_s.split('.')[-1] : nil
      if extension && allowed_extensions.include?(extension) && context.pathname.basename.to_s.match(/\.rtl/i)
        Rtlize::RTLizer.transform(data)
      else
        data
      end
    end
  end
end
