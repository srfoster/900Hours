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
end
