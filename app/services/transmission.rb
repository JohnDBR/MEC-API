class Transmission
  attr_accessor :picture, :pictures, :errors, :empty_params

  def initialize
    @picture = nil
    @pictures = {}
    @errors = {}
    @empty_params = false
  end

  def create_pictures(params, entity, entity_type)
    @empty_params = true
    params.each do |key, options|
      if key.include?("image")
        @empty_params = false
        picture = nil 
        if entity_type.eql? "carousel"
          picture = CarouselPicture.new(carousel:entity, picture:options)
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
          if entity_type.eql? "carousel"
            picture = CarouselPicture.find(action[1])
          else
            @errors[key] = 'invalid entity_type'
          end
          if picture
            if entity_type.eql? "carousel"
              if picture.carousel.id != entity.id
                picture = nil 
                @errors[key] = 'invalid carousel picture for the provided carousel'
              end
            end
          else
            @errors[key] = 'picture not found'  
          end
        else
          if entity_type.eql? "carousel"
            picture = CarouselPicture.find_by(carousel: entity)
          else
            @errors[key] = 'invalid entity_type'
          end
          if picture.nil?
            @errors[key] = 'picture not found'  
          end
        end
        if action.last.eql? "create"
          if entity_type.eql? "carousel"
            picture = CarouselPicture.new(carousel: entity, picture:options)
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
          if entity_type.eql? "carousel"
            picture = CarouselPicture.new(carousel:entity, picture:options)
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

end 