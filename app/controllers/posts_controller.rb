class PostsController < ApplicationController

  #before_filter :authenticate_user!, :except => [:index]

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(permit_params)
    if @post.save
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    @post = Post.find params[:id]
    if @post.update(permit_params)
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def index
    @posts = Post.all.order('created_at DESC')
  end

  def my_posts
    @posts = current_user.my_posts
    render 'index'
  end

  private

  def permit_params
    params.require(:post).permit(:id, :title, :description, :country, :place, :visited_on, :photo, :user_id)
  end
end
