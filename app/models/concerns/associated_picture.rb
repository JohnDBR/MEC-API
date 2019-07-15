module AssociatedPicture
  extend ActiveSupport::Concern

  included do
    mount_uploader :picture, PictureUploader
    after_destroy :delete_folder 
  end

  def delete_folder
    FileUtils.rm_rf(
      File.join(
        Rails.root, 
        'public/public', 
        self.model_name.name.downcase, 
        'picture', 
        self.id.to_s
      )
    ) if self.picture
  end
end