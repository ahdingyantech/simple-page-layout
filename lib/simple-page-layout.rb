module SimplePageLayout
  module Helper
    def simple_page_layout(*args, &block)
      options = args.last

      haml_tag :html, :lang => options[:html_lang] do
        _render_page_layout_head
        _render_page_layout_body(&block)
      end
    end

    def page_title(title)
      content_for(:title) do
        title
      end
    end

    def _render_page_title
      site_name  = 'MINDPIN EduShare'
      yield_title = content_for :title
      page_title = yield_title.blank? ? site_name : "#{site_name} | #{yield_title}" rescue 'SITE_NAME'
      
      haml_tag :title, page_title
    end

    def _render_page_layout_head
      head_ext = content_for :head
      css_ext = content_for :css

      haml_tag :head do
        _render_page_title
        haml_concat csrf_meta_tags
        haml_concat stylesheet_link_tag(:application)
        haml_concat head_ext if head_ext.present?
        haml_concat css_ext if css_ext.present?
      end
    end

    def _render_page_layout_body(&block)
      javascript_ext = content_for :javascript

      haml_tag :body do
        yield
        haml_concat javascript_include_tag(:application)
        haml_concat javascript_ext if javascript_ext.present?
      end
    end
  end

  class Railtie < Rails::Railtie
    initializer 'SimplePageLayout.helper' do |app|
      ActionView::Base.send :include, SimplePageLayout::Helper
    end
  end
end