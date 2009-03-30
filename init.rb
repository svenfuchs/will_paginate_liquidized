
WillPaginate.send :include, WillPaginate::Liquidized
Liquid::Template.register_filter(WillPaginate::Liquidized::ViewHelpers)
