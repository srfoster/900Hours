class NotesController < ApplicationController
  def update 
    @note = Note.find(params[:id])
    @note.update_attributes(params[:note]) 
    render :nothing => true
  end

  def show
    @note = Note.find(params[:id])

    respond_to do |format|
      format.json do 
        render :json => @note
      end
    end
  end

  def create
    hour = Hour.find(params[:hour_id])

    if params[:note_type] == "Teacher"
       user = current_user
       @note = hour.add_teacher_note("", user)
    else
       user = hour.user
       @note = hour.add_student_note("", user)
    end

    
    partial = render_to_string(:partial => "hours/note_list_item.html.erb", :locals => {:hour => hour, :note => @note} )

    respond_to do |format|
      format.json do 
        render :json => {:note => @note, :partial => partial}
      end
    end
  end

  def destroy
    note = Note.find(params[:id])
    note.tag("Deleted")

    render :nothing => true
  end
end
