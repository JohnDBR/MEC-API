class Transmission
  attr_accessor :picture, :pictures, :errors, :empty_params

  def initialize
    @picture = nil
    @pictures = {}
    @errors = {}
    @empty_params = false
  end

  def create_picture(params, entity)
    if params[:image].nil?
      @empty_params = true
      @errors[:upload_fail] = 'no photo to storage'
      return false
    else
      @picture = Picture.new(image:params[:image])
      if @picture.save 
        if entity.picture then entity.picture.destroy end 
        entity.update_attribute(:picture_id, @picture.id)  
        return true 
      else 
        @errors[:storage_fail] = @picture.errors.messages 
        return false 
      end
    end
  end

  def create_pictures(params, entity, entity_type)
    @empty_params = true
    params.each do |key, options|
      if key.include?("image")
        @empty_params = false
        picture = nil 
        if entity_type.eql? "challenge"
          picture = ChallengePicture.new(challenge:entity, image:options)
        elsif entity_type.eql? "idea"
          picture = IdeaPicture.new(idea:entity, image:options)
        else
          @errors[key] = 'invalid entity_type'
        end
        if picture
          if picture.save
            @pictures[key] = picture
          else  
            @errors[:storage_fail] = picture.errors.messages 
          end
        end
      end
    end
    @errors[:storage_fail] = 'no photo to storage' if @empty_params
  end

  def manage_pictures(params, entity, entity_type)
    @empty_params = true
    params.each do |key, options|
      if key.include?("image")
        @empty_params = false
        picture = nil 
        action = key.split("_")
        if action.length.eql? 3
          if entity_type.eql? "challenge"
            picture = ChallengePicture.find(action[1])
          elsif entity_type.eql? "idea"
            picture = IdeaPicture.find(action[1])
          else
            @errors[key] = 'invalid entity_type'
          end
          if picture
            if entity_type.eql? "challenge"
              if picture.challenge.id != entity.id
                picture = nil 
                @errors[key] = 'invalid challenge picture for the provided challenge'
              end
            else entity_type.eql? "idea"
              if picture.idea.id != entity.id
                picture = nil 
                @errors[key] = 'invalid idea picture for the provided idea'
              end
            end
          else
            @errors[key] = 'picture not found'  
          end
        else
          if entity_type.eql? "challenge"
            picture = ChallengePicture.find_by(challenge: entity)
          elsif entity_type.eql? "idea"
            picture = IdeaPicture.find_by(idea: entity)
          else
            @errors[key] = 'invalid entity_type'
          end
          if picture.nil?
            @errors[key] = 'picture not found'  
          end
        end
        if action.last.eql? "create"
          if entity_type.eql? "challenge"
            picture = ChallengePicture.new(challenge: entity, image:options)
          elsif entity_type.eql? "idea"
            picture = IdeaPicture.new(idea: entity, image:options)
          end
          if picture.save
            @pictures[key] = picture
          else  
            @errors[:storage_fail] = picture.errors.messages 
          end
        elsif picture and action.last.eql? "destroy"
          if picture.destroy
            @pictures[key] = 'picture destroyed'
          else  
            @errors[key] = picture.errors.messages 
          end
        elsif picture and action.last.eql? "update"
          picture.destroy  
          picture = nil
          if entity_type.eql? "challenge"
            picture = ChallengePicture.new(challenge:entity, image:options)
          elsif entity_type.eql? "idea"
            picture = IdeaPicture.new(idea:entity, image:options)
          else
            @errors[key] = 'invalid entity_type'
          end
          if picture
            if picture.save
              @pictures[key] = picture
            else  
              @errors[key] = picture.errors.messages 
            end
          end
        else
          @errors[key] = 'invalid action to perform'
        end
      end
    end
    @errors[:storage_fail] = 'no photo to perform an action' if @empty_params
  end

  def save_remote_url_picture(picture_url, entity)
    unless picture_url
      @empty_params = true
      @errors[:storage_photo_url_fail] = 'no photo url to storage'
      return false
    else
      #open() shoudl be tested! LATER
      @picture = Picture.new(image:open(picture_url))
      if @picture.save 
        if entity.picture then entity.picture.destroy end 
        entity.update_attribute(:picture_id, @picture.id)  
        return true 
      else 
        @errors[:storage_photo_url_fail] = @picture.errors.messages 
        return false 
      end
    end
  end
end 