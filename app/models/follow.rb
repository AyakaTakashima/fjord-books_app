# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :following, class_name: 'User'
  belongs_to :follower, class_name: 'User'
  validates :following_id, presence: true
  validates :follower_id, presence: true
end
