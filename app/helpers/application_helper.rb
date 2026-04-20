# frozen_string_literal: true

module ApplicationHelper
  def bulletin_state_color(state)
    colors = {
      'draft' => 'secondary',
      'under_moderation' => 'warning',
      'published' => 'success',
      'rejected' => 'danger',
      'archived' => 'dark'
    }

    colors[state] || 'light'
  end

  def nav_item_link(name, link_path)
    link_to name, link_path, class: class_names('list-group-item', 'list-group-item-action', active: current_page?(link_path))
  end
end
