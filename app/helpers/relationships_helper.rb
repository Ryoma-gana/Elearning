module RelationshipsHelper

    def relationship_activity(followed)
        User.find(followed)
    end
    
    def relationship(rel)
        User.find(rel)
    end
end
