# frozen_string_literal: true

class Web::Admin::ApplicationController < Web::ApplicationController
  layout 'web/admin/application'

  before_action :authenticate_admin!

  private

  def authenticate_admin!
    return if current_user&.admin?

    redirect_to root_path, alert: t('admin.access_denied')
  end
end
