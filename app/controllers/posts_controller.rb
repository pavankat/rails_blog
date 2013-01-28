class PostsController < ApplicationController
  
  http_basic_authenticate_with :name => "dhh", 
  :password => "secret", 
  :except => [:index, :show]
  # Rails provides a very simple HTTP authentication system
  

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    # Post.all returns all of the posts currently in the 
    # database as an array of Post records that we store 
    # in an instance variable called @posts.
    # http://guides.rubyonrails.org/active_record_querying.html

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
    # The respond_to block handles both HTML and JSON calls 
    # to this action. If you browse to 
    # http://localhost:3000/posts.json, you’ll see a JSON 
    # containing all of the posts. 
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    # when you go to http://localhost:3000/posts/1, rails interprets this
    # as a call to the show action for the resource and passes 1 to the 
    # :id paramater. Using this blog app you can do that by clicking the 
    # show link for a post on the index page.

    @post = Post.find(params[:id])
    # The show action uses Post.find to search for a single record 
    # in the database by its id value. After finding the record, Rails 
    # displays it by using app/views/posts/show.html.erb
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    # Creating a new post involves two actions. 
    # The first is the new action, which 
    # instantiates an empty Post object
    # The new.html.erb view displays this 
    # empty Post to the user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    # Like creating a new post, editing a post is a two-part process. 
    # The first step is a request to edit_post_path(@post) with a 
    # particular post. This calls the edit action in the controller

    # After finding the requested post, Rails uses the edit.html.erb 
    # view to display it:

  end

  # POST /posts
  # POST /posts.json
  def create
    # When the user clicks the Create Post button on this form, 
    # the browser will send information back to the create action
    # of the controller (Rails knows to call the create action 
    # because the form is sent with an HTTP POST request; that’s 
    # one of the conventions that were mentioned earlier)

    @post = Post.new(params[:post])
    # The create action instantiates a new Post object from the data 
    # supplied by the user on the form, which Rails makes available in 
    # the params hash.

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      # After successfully SAVING the new post, CREATE returns 
      # the appropriate format that the user has requested 
      # (HTML in our case). It then redirects the user to the 
      # resulting POST SHOW ACTION and sets a NOTICE to the 
      # user that the Post was successfully created.

      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      # If the post was not successfully saved, due to a validation error, 
      # then the controller returns the user back to the new action with 
      # any error messages so that the user has the chance to fix the error 
      # and try again.

      # The “Post was successfully created.” message is stored in the 
      # Rails flash hash (usually just called the flash), so that messages 
      # can be carried over to another action, providing the user with 
      # useful information on the status of their request. In the case 
      # of create, the user never actually sees any page rendered during 
      # the post creation process, because it immediately redirects to the 
      # new Post as soon as Rails saves the record. The Flash carries over 
      # a message to the next action, so that when the user is redirected 
      # back to the show action, they are presented with a message saying 
      # “Post was successfully created.”

      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    # In the update action, Rails first uses 
    # the :id parameter passed back from the 
    # edit view to locate the database record 
    # that’s being edited. The update_attributes 
    # call then takes the post parameter (a hash) 
    # from the request and applies it to this record. 
    # If all goes well, the user is redirected to the 
    # post’s show action. If there are any problems, it 
    # redirects back to the edit action to correct them.

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    # The destroy method of an Active Record model instance 
    # removes the corresponding record from the database. After 
    # that’s done, there isn’t any record to display, so Rails 
    # redirects the user’s browser to the index action of the controller.

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
