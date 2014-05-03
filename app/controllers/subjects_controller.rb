class SubjectsController < ApplicationController
  layout false

  def index
    @subjects = Subject.sorted

  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({:name => "Default"})
  end

  def create
    #instantiate new object
    @subject = Subject.new(subject_params)
    #save object
    if @subject.save
      # if save succeeds, redirect
      flash[:notice] = "Subject created successfully"
      redirect_to(:action => 'index')
    else
      # if save fails, display form again

      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])

  end

  def update
    #Find a subject
    @subject = Subject.find(params[:id])
    #update object
    if @subject.update_attributes(subject_params)
    # if update succeeds, redirect
    flash[:notice] = "Subject updated successfully"
      redirect_to(:action => 'show', :id => @subject.id)
    else
      # if update fails, display form again

      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])


  end

  def destroy
    subject = Subject.find(params[:id])
    subject.destroy
    flash[:notice] = "Subject '#{subject.name}' destroyed successfully"
    redirect_to(:action => 'index')

  end


  private
  def subject_params
    # in order to white list the parameters of Subject to be mass assigned
    params.require(:subject).permit(:name, :position, :visible)

  end

end
