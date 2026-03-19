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
end
