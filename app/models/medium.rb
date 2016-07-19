class Medium < ApplicationRecord
  mount_uploader :file_name, MediaUploader
  belongs_to :slideshow
  before_create :check_image
  # after_save :change_file_name

  def check_image
    if slideshow.media.where.not(order: nil).empty?
      self.order = 1
    else
      last_order = slideshow.media.where.not(order: nil).last.order
      self.order = last_order + 1
    end
  end

  # def change_file_name
  #   byebug
  #   self.update(file_name: "image#{self.order}")
  # end
end
