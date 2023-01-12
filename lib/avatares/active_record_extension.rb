module Avatares 
  module ActiveRecordExtension
    #Converts the model into avatarable allowing to call "model".avatar
    def acts_as_avatarable
      include Avatares::Avatarable
    end
  end
end
