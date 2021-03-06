# frozen_string_literal: true

module Mention
  private

  def friends_names
    names_array = []
    user.following_users.each do |friend|
      names_array << friend.name
    end
    names_array
  end

  def html_type
    if is_a?(Post)
      content_html
    elsif is_a?(Comment)
      comment_html
    end
  end

  def mentioned_friends
    friends_names.select { |name| html_type.include? name }
  end

  def add_mention_links_to_content
    mentioned_friends.each do |friend_name|
      slug = User.find_by(name: friend_name).slug
      new_content = html_type.gsub!(friend_name, "<a href='/users/#{slug}'>#{friend_name}</a>")
      self.content = new_content if is_a?(Post)
      self.comment = new_content if is_a?(Comment)
    end
  end
end
