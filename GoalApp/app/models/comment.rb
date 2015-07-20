class Comment < ActiveRecord::Base

  validates :body, :commentable, presence: true

  belongs_to :commentable, polymorphic: true

end
