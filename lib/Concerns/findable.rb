#could also be written 
    #module Concerns::Findable
        #or

module Concerns #define a module named Concerns
    module Findable #make a Findable module inside Concern module
        #.find_by_name: searching the extended class's @@all variable for an instance method that matched the provided name
        def find_by_name(name)
            self.all.detect {|o| o.name == name} 
            #use self.all b/c all.detect would refer to the module we are in)
        end

        def find_or_create_by_name(name)
            find_by_name(name) || self.create(name)
        end
    end
end
