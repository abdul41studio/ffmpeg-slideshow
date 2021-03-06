class MediaController < ApplicationController
  before_action :set_slideshow

  def index
    @slideshow.check_picture
    @media = Medium.all.order(created_at: :asc)
  end

  def create
    count = params[:count].to_i
    params[:file].each do |key, value|
      @slideshow.media.create(file_name: value)
    end
    @slideshow.last_picture_update(count)
    @media = @slideshow.media.order(created_at: :desc).limit(count).reverse
    render json: @media
    # @media = @slideshow.media.new(file_name: params[:file])
    # if @media.save!
    #   render json: @media
    # else
    #   render json: { error: 'Failed to process' }, status: 422
    # end
  end

  def create_video
    `ffmpeg -framerate 1/5 -start_number 1 -i public/uploads/medium/file_name/#{@slideshow.indicator_name}/image%d.jpg -i app/assets/audios/music.mp3 -c:v libx264 -r 30 -pix_fmt yuv420p -shortest public/uploads/tmp/video.mp4`
    @slideshow.video =  File.open("public/uploads/tmp/video.mp4")
    @slideshow.save
    if File.exist?("public/uploads/tmp/video.mp4")
      File.delete("public/uploads/tmp/video.mp4")
    end
    redirect_to slideshow_slide_show_path
  end

  def slideshow
    @video = @slideshow
  end

  def delete_media
    Medium.where(id: params[:media]).each do |medium|
      medium.remove_file_name!
      medium.destroy
    end
    @slideshow.medium_reorder
    redirect_to slideshow_media_path(slideshow_id: @slideshow.id)
  end

  def delete_all
    @slideshow.media.each do |medium|
      medium.remove_file_name!
      medium.destroy
    end
    redirect_to slideshow_media_path(slideshow_id: @slideshow.id)
  end

  private
    def set_slideshow
      @slideshow = Slideshow.find(params[:slideshow_id])
    end
end
