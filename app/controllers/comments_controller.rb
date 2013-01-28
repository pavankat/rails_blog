class CommentsController < ApplicationController
  
  http_basic_authenticate_with :name => "dhh", 
  :password => "secret", 
  :only => :destroy
  # We also only want to allow authenticated users to delete comments

  # following rails command made this:
  # rails generate controller Comments
  def create
    @post = Post.find(params[:post_id])
    # Each request for a comment has to keep track 
    # of the post to which the comment is attached, 
    # thus the initial call to the find method of the 
    # Post model to get the post in question.
    @comment = @post.comments.create(params[:comment])
    # the code takes advantage of some of the methods available 
    # for an association. 
    # We use the create method on @post.comments 
    # to create and save the comment. This will automatically 
    # link the comment so that it belongs to that particular post.


    redirect_to post_path(@post)
    # Once we have made the new comment, 
    # we send the user back to the original 
    # post using the post_path(@post) helper. 
    # As we have already seen, this calls the 
    # show action of the PostsController which 
    # in turn renders the show.html.erb template. 
  end

def destroy
    @post = Post.find(params[:post_id])
    # The destroy action will find the post we are looking at

    @comment = @post.comments.find(params[:id])
    # locate the comment within the @post.comments collection

    @comment.destroy
    # and then remove it from the database

    redirect_to post_path(@post)
    # and send us back to the show action for the post.
  end
end