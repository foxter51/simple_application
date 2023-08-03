# frozen_string_literal: true

# Represents policy for Like
class LikePolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def destroy?
    user.present? && (user == like.user || user.has_role?(:admin) || user.has_role?(:manager))
  end

  private

  def like
    record
  end
end
