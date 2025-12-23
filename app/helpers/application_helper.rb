module ApplicationHelper
  include Auth

  def nav_item_link(name, link_path)
    link_to name, link_path, class: class_names("nav-link", "link-dark", active: current_page?(link_path))
  end
end
