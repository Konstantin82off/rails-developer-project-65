# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    user.admin?
  end

  def edit?
    user.admin? && record != user # Админ не может редактировать себя
  end

  def update?
    user.admin? && record != user
  end
end
