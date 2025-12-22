# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def show?
    @record.published? || author? || @user.admin?
  end

  def update?
    author?
  end

  def edit?
    update?
  end

  def to_moderate?
    update?
  end

  def archive?
    update?
  end

  private

  def author?
    @record.user_id == @user&.id
  end
end
