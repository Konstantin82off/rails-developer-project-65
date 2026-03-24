# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    user.present?
  end

  def create?
    user.present?
  end

  def edit?
    user.present? && (user.admin? || record.user == user)
  end

  def update?
    user.present? && (user.admin? || record.user == user)
  end

  def to_moderate?
    user.present? && record.user == user && record.draft?
  end

  def archive?
    user.present? && (user.admin? || record.user == user) && !record.archived?
  end

  def publish?
    user&.admin? && record.under_moderation?
  end

  def reject?
    user&.admin? && record.under_moderation?
  end

  def destroy?
    user&.admin?
  end
end
