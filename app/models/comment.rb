class Comment < ActiveRecord::Base
  include ActsAsCommentable::Comment
  include Shared::Callbacks
  # include Mention

  belongs_to :commentable, polymorphic: true, counter_cache: true
  default_scope -> { order('created_at ASC') }

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  acts_as_votable

  # NOTE: Comments belong to a user
  belongs_to :user

  include PublicActivity::Model
  tracked only: [:create, :like], owner: proc { |_controller, model| model.user }

  validates_presence_of :comment
  validates_presence_of :commentable
  validates_presence_of :user
end