class UsersController < ApplicationController
    def index
      study_taggings = Tagging.find_all_by_tag_id(Tag.find_by_name("case_study"))
      @users = study_taggings.collect{|t| t.taggable }
    end

    def update
      @user = User.find(params[:id])
      @user.update_attributes(params[:user])
      render :nothing => true
    end

    def show
      @user = User.find(params[:id])
      respond_to do |format|
        format.html 
        format.json { render json: @user  }
      end 
    end
end
