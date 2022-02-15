# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  # 能動的関係
  has_many :active_follows, class_name:  "Follow",
            foreign_key: "follower_id",
            dependent:   :destroy
  has_many :followings, through: :active_follows

  #受動的関係
  has_many :passive_follows, class_name:  "Follow",
            foreign_key: "follower_id",
            dependent:   :destroy
  has_many :followers, through: :passive_follows

  def follow(other_user)
    active_follows.create(following_id: other_user.id)
  end

  def unfollow(other_user)
    active_follows.find_by(following_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end
end
