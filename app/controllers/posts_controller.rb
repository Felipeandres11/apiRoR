class PostsController < ApplicationController
    
    
   

    rescue_from Exception do |e|
        render json: {error: e.message}, status: :internal_error
    end

     #error 500
    rescue_from ActiveRecord::RecordInvalid do |e|
        render json: {error: e.message}, status: :unprocessable_entity
    end 


    #GET /post
    def index 
      @posts = Post.where(published: true)

      render json: @posts, status: :ok 
    end

    # GET /post/{id}
    def show 
        @post = Post.find(params[:id])
        render json: @post, status: :ok
    end

    #POST /posts
    def create 
       
        @post = Post.create!(create_params)
        render json: @post, status: :created
    
    end 

    #PUT /posts/{id}
    def update 
        @post = Post.find(params[:id])
        @post.update!(update_params)

        render json: @post, status: :ok
    end


    private 

    def create_params 
        params.require(:post).permit(:title, :content, :published, :user_id)
    end
    
    def update_params 
        params.require(:post).permit(:title, :content, :published)
    end


end
