module ApplicationHelper
##
  def sidebar_link_to(path, emoji, text)
    classes = %w[my-1 nav-link text-white]
    classes << "active" if current_page?(path)

    link_to(path, class: classes) do
      tag.span(class: "me-2") { emoji } + tag.span { text }
    end
  end

  def icon(icon_name)
    tag.i(class: ["bi", "bi-#{icon_name}"])
  end

  def icon_with_text(icon_name, text)
    tag.span(icon(icon_name), class: "me-2") + tag.span(text)
  end

  def turbo_stream_flash
    turbo_stream.update "flash", partial: "flash"
  end

##
    def fix_value( varx , default_value = 0)
        if varx
            varx.to_i
        else
            default_value
        end
    end

    def logx_config(path, addional_path = nil)
        top_pathname = Pathname.new(path)
        top_pathname = top_path + additional_path if additional_path
        yaml_pathname = top_pathname + "config/logger.yml"
        content = yaml_pathname.read()
        YAML.safe_load(content)
    end

    module_function :fix_value
end
