# frozen_string_literal: true

# Represents policy for Comment
class CommentPolicy < ApplicationPolicy
  def new?
    user.present?
  end

  def create?
    new?
  end

  def destroy?
    user.present? && (user == comment.user || user.has_role?(:admin) || user.has_role?(:manager))
  end

  private

  def comment
    record
  end
end
