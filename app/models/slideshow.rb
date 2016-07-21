class Slideshow < ApplicationRecord
  has_many :media, dependent: :destroy
  mount_uploader :video, SlideshowUploader
  before_create :set_indicator_name

  def set_indicator_name
    if Slideshow.where.not(id: nil).empty?
      indicator = 1
    else
      last_slideshow = Slideshow.where.not(id: nil).last
      indicator =  last_slideshow.id + 1
    end
    self.indicator_name = "slideshow#{indicator}"
  end

  def medium_reorder
    order = 1
    media.each do |media|
      name_order = "image#{order}.jpg"
      base_name = File.basename(media.file_name.url)
      file_path = media.file_name.path.gsub(base_name, "")
      media.update(order: order, file_name: name_order)
      if base_name != name_order
        File.rename(media.file_name.path, "#{file_path}#{name_order}")
      end
      order = order+1
    end
  end

  def check_picture
    if !media.empty?
      media.each do |medium|
        name_order = "image#{medium.order}.jpg"
        if File.basename(medium.file_name.url) != name_order
          medium.update(file_name: name_order)
        end
      end
    end
  end

  def last_picture_update(count)
    media.order(created_at: :desc).limit(count).each do |medium|
      name_order = "image#{medium.order}.jpg"
      medium.update(file_name: name_order)
    end
  end
end
