class Post < ActiveRecord::Base
	# following rails command made this along with a bunch of other files:
	# $ rails generate scaffold Post name:string title:string content:text

  attr_accessible :content, :name, :title, :tags_attributes

  # note we had to add :tags_attributes 
  # to the attr_accessible list. If we didn’t 
  # do this there would be a MassAssignmentSecurity 
  # exception when we try to update tags through our posts model.


	# An important part of this file is attr_accessible. 
	# It specifies a whitelist of attributes that are allowed 
	# to be updated in bulk (via update_attributes for instance).

	validates :name, :presence => true
	validates :title, :presence => true,
		:length => { :minimum => 5 }
	# http://guides.rubyonrails.org/
	# active_record_validations_callbacks.html#validations-overview

	has_many :comments, :dependent => :destroy
	has_many :tags
	# The above declaration along with the belongs_to in 
	# comments.rb enable a good bit of automatic behavior.
	# For example, if you have an instance variable @post containing a 
	# post, you can retrieve all the comments belonging to that post as
	# an array using @post.comments.

	# :dependent => :destroy
	# If you delete a post then its associated 
	# comments will also need to be deleted. 

	accepts_nested_attributes_for :tags, :allow_destroy => :true,
	:reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

	# :allow_destroy option tells Rails to enable destroying tags 
	# through the nested attributes 
	# (you’ll handle that by displaying a “remove” checkbox 
	# on the view that you’ll build shortly). 

	# The :reject_if option prevents saving new tags that do 
	# not have any attributes filled in.

	# more on associations: 
	# http://guides.rubyonrails.org/association_basics.html


end
