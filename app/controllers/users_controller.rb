class UsersController < ApplicationController
    def index
      if current_user.nil? or !is_admin(current_user) 
        study_taggings = Tagging.find_all_by_tag_id(Tag.find_by_name("case_study"))
        @users = study_taggings.collect{|t| t.taggable }
      end
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
