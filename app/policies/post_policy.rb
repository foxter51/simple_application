# frozen_string_literal: true

# Represents policy for Post
class PostPolicy < ApplicationPolicy
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
    new?
  end

  def edit?
    update?
  end

  def update?
    user.present? && (user == post.user || user.has_role?(:admin) || user.has_role?(:manager))
  end

  def destroy?
    user.present? && (user == post.user || user.has_role?(:admin) || user.has_role?(:manager))
  end

  private

  def post
    record
  end
end
