class ApplicationRequestsController < ApplicationController
    def create
        if params[:commit] == "Apply As a Student"
          ApplicationRequest.create_new_student_request(current_user)
        elsif params[:commit] == "Apply As a Teacher"
          ApplicationRequest.create_new_teacher_request(current_user)
        else
           raise "Bad value"
        end

        redirect_to :back
    end

    def destroy
        req = ApplicationRequest.find(params[:id])
        req.tag "Deleted"
        redirect_to :back
    end
end
