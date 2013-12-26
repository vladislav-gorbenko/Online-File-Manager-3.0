class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :commentable_type, :content, :user_id, :parent_id

  has_ancestry
  
  has_many :votes, :dependent => :destroy
  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  validates :content, presence: true

  def vote_up
    updated = self.votes_up ? self.votes_up + 1 : 1 
    self.update_attribute(:votes_up, updated)    
  end

  def vote_down
    updated = self.votes_down ? self.votes_down + 1 : 1
    self.update_attribute(:votes_down, updated)
  end
end
