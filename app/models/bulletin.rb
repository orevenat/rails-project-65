# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  belongs_to :category
  belongs_to :user

  has_one_attached :image

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }

  aasm column: :state do
    state :draft, initial: true
    state :under_moderation, :published, :rejected, :archived

    event :to_moderate do
      transitions from: :draft, to: :under_moderation
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :archive do
      transitions from: %i[rejected published draft], to: :archived
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end
  end

  def self.ransackable_attributes(_ = nil)
    %w[category_id created_at description id state title updated_at user_id]
  end
end
