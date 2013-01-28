class Comment < ActiveRecord::Base
	# the following rails command made this model:
	# $ rails generate model Comment commenter:string 
	# body:text post:references
  belongs_to :post
  # This is very similar to the post.rb model 
  # that you saw earlier. The difference is the line 
  # belongs_to :post, which sets up an Active Record association. 

  attr_accessible :body, :commenter
end
