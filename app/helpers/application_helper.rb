module ApplicationHelper

  def embed_code(file)
    CGI.escapeHTML(render file: file).html_safe
  end
end
