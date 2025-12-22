# frozen_string_literal: true

class AddAdminToMyUser < ActiveRecord::Migration[8.1]
  def change
    User.find_or_initialize_by(email: 'agrry@yandex.ru') do |user|
      user.admin = true
      user.name = 'Ruslan Knyazev'
      user.save
    end
  end
end
