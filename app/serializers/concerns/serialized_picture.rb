module SerializedPicture
  extend ActiveSupport::Concern

  included do
    attribute :picture
  end

  #module ClassMethods
    def picture
      if self.object.picture
        url_helper = ApplicationController.default_url_options 
        "#{url_helper[:protocol]}://#{url_helper[:host]}#{self.object.picture.url}"
      end
    end
  #end
end