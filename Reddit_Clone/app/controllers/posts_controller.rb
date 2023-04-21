class PostsController < ApplicationController

    def new
        
    end

    def create

    end

    def show

    end

    def edit
        @post = Post.find_by(params[:id])
    end

    def update

    end

    def destroy

    end
end
