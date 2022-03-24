# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :active_follows, class_name: 'Follow',
                            foreign_key: 'follower_id',
                            dependent: :destroy,
                            inverse_of: :follower
  has_many :followings, through: :active_follows

  has_many :passive_follows, class_name: 'Follow',
                             foreign_key: 'following_id',
                             dependent: :destroy,
                             inverse_of: :following
  has_many :followers, through: :passive_follows

  paginates_per 10

  def follow!(other_user)
    active_follows.create(following_id: other_user.id)
  end

  def unfollow(other_user)
    active_follows.find_by(following_id: other_user.id).destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end
end
