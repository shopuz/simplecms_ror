class SectionsController < ApplicationController
  layout "admin"

  before_action :confirm_logged_in

  
  def index
    @sections = Section.sorted
  end

  def show
    @section = Section.find(params[:id])

  end

  def new
    @section = Section.new
    @section_count = Section.count + 1
    @pages = Page.order('position ASC')
  end

  def create
    @section = Section.new(section_params)

    if @section.save
      flash[:notice] = "Section created successfully"
      redirect_to(:action => 'index')
    else
      @section_count = Section.count + 1
      @pages = Page.order('position ASC')
      render ('new')
    end

  end

  def edit
    @section = Section.find(params[:id])
    @section_count = Section.count 
    @pages = Page.order('position ASC')
  end

  def update
    @section = Section.find(params[:id])

    if @section.update_attributes(section_params)
      flash[:notice] = "Section updated successfully"
      redirect_to(:action => 'show', :id => @section.id)
    else
      @section_count = Section.count
      @pages = Page.order('position ASC')
      render ('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    section = Section.find(params[:id])
    section.destroy
    flash[:notice] = "Section '#{section.name}' destroyed successfully"
    redirect_to(:action => 'index')
  end

  private

  def section_params
    params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
  end
end
