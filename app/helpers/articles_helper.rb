module ArticlesHelper
  
  def category_items(names, records, options={})
    class_name = options.fetch(:class, "")
    link_class_name = options.fetch(:link_class, "")
    result = ""
    names.join(",, ").split(", ").zip(records).each do |name, record|
      result += "<li class=\"#{class_name}\">" + link_to(name, category_articles_path(record), class: link_class_name) + "</li> "
    end
    result.html_safe
  end
end
