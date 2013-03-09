module SimplePageLayout
  module Helper
    class PageLayout
      attr_accessor :view
      attr_accessor :site_name, :html_lang

      def initialize(view, site_name, options = {})
        @view = view
        @site_name = site_name
        @html_lang = options[:html_lang]
      end

      def render(&block)
        @view.haml_tag :html, :lang => html_lang do
          render_page_layout_head
          render_page_layout_body(&block)
        end
      end

      def render_page_layout_head
        head_ext = @view.content_for :head
        css_ext  = @view.content_for :css

        @view.haml_tag :head do
          render_page_title
          @view.haml_concat @view.csrf_meta_tags
          @view.haml_concat @view.stylesheet_link_tag(:application)
          @view.haml_concat head_ext if head_ext.present?
          @view.haml_concat css_ext if css_ext.present?
        end
      end

      def render_page_layout_body(&block)
        javascript_ext = @view.content_for :javascript

        @view.haml_tag :body do
          yield
          @view.haml_concat @view.javascript_include_tag(:application)
          @view.haml_concat @view.javascript_ext if javascript_ext.present?
        end
      end

      def render_page_title
        yield_title = @view.content_for :title
        page_title = yield_title.blank? ? @site_name : "#{@site_name} | #{yield_title}" rescue 'SITE_NAME'
        
        @view.haml_tag :title, page_title
      end
    end

    def simple_page_layout(site_name, options = {}, &block)
      page_layout = PageLayout.new self, site_name, options
      page_layout.render &block
    end
  end

  module ExtHelper
    def page_title(title)
      content_for(:title) do
        title
      end
    end
  end

  class Railtie < Rails::Railtie
    initializer 'SimplePageLayout.helper' do |app|
      ActionView::Base.send :include, SimplePageLayout::Helper
      ActionView::Base.send :include, SimplePageLayout::ExtHelper
    end
  end
end