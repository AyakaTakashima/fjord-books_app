# frozen_string_literal: true

class AddUserToReports < ActiveRecord::Migration[6.1]
  def change
    add_reference :reports, :user, foreign_key: true
  end
end
