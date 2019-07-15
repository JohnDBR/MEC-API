module AssociatedFile
  extend ActiveSupport::Concern

  included do
    after_destroy :delete_document
  end

  def delete_document
    delete_path = ""
    begin
      delete_path = Rails.root.join(picture_url) 
    rescue Exception => e
      delete_path = file.path
    end
    File.delete(delete_path) if File.exist?(delete_path)
  end

  module ClassMethods
    def get_picture_url
      begin
        picture_url = "#{self::PATH}/#{SecureRandom.uuid.gsub(/-/, '')}.pdf"
      end while (where(picture_url:picture_url).any?)  
      picture_url
    end
  end
end