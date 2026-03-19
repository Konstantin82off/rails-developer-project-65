# frozen_string_literal: true

module Web
  class ProfilesController < ApplicationController
    before_action :authenticate_user!

    def show
      @bulletins = current_user.bulletins.ordered
    end
  end
end
