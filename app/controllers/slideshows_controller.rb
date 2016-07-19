class SlideshowsController < ApplicationController

  before_action :set_slideshow, only: :destroy

  def index
    @slideshows = Slideshow.all.order(created_at: :desc)
  end

  def new
    @slideshow = Slideshow.new
  end

  def create
    @slideshow = Slideshow.new(slideshow_params)
    respond_to do |format|
      if @slideshow.save
        format.html { redirect_to slideshow_media_path(slideshow_id: @slideshow.id) }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @slideshow.destroy
    redirect_to slideshows_path, notice: "Slideshow Has been Successfully deleted"
  end

  private
    def set_slideshow
      @slideshow = Slideshow.find(params[:id])
    end

    def slideshow_params
      params.require(:slideshow).permit(:name)
    end
end
