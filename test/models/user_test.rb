# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'name_or_email method should return email without name' do
    user = User.new(email: 'hoge@example.com', name: '')
    assert_equal 'hoge@example.com', user.name_or_email

    user.name = 'Hoge'
    assert_equal 'Hoge', user.name_or_email
  end

  test 'following? method should return true if me followed she' do
    me = User.create!(email: 'me@example.com', password: 'password')
    she = User.create!(email: 'she@example.com', password: 'password')

    assert_not me.following?(she)
    Relationship.create(following_id: she.id, follower_id: me.id)
    assert me.following?(she)
  end

  test 'followed_by? method should return true if me was followed she' do
    me = User.create!(email: 'me@example.com', password: 'password')
    she = User.create!(email: 'she@example.com', password: 'password')

    assert_not me.followed_by?(she)
    Relationship.create!(following_id: me.id, follower_id: she.id)
    assert me.followed_by?(she)
  end

  test 'follow method should follow someone' do
    me = User.create!(email: 'me@example.com', password: 'password')
    she = User.create!(email: 'she@example.com', password: 'password')

    assert_not me.following?(she)
    me.follow(she)
    assert me.following?(she)
  end

  test 'unfollow method should unfollow someone' do
    me = User.create!(email: 'me@example.com', password: 'password')
    she = User.create!(email: 'she@example.com', password: 'password')

    me.follow(she)
    assert me.following?(she)
    me.unfollow(she)
    assert_not me.following?(she)
  end
end
