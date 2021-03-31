# frozen_string_literal: true

class Follow < ApplicationRecord
  extend ActsAsFollower::FollowerLib
  extend ActsAsFollower::FollowScopes

  include PublicActivity::Model
  tracked

  # NOTE: Follows belong to the "followable" and "follower" interface
  belongs_to :followable, polymorphic: true
  belongs_to :follower,   polymorphic: true

  def block!
    update_attribute(:blocked, true)
  end
end
