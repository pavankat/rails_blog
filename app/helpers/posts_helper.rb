module PostsHelper
	# View Helpers live in app/helpers and 
	# provide small snippets of reusable code 
	# for views. In our case, we want a method 
	# that strings a bunch of objects together 
	# using their name attribute and joining them 
	# with a comma.

  def join_tags(post)
    post.tags.map { |t| t.name }.join(", ")
  end
end