class Category < ActiveRecord::Base
        
    #gem friendy_id
    include FriendlyId
    friendly_id :description, use: :slugged
    # Associations
    has_many :ads

    #validationa
    validates_presence_of :description

    #scopes
    scope :order_by_description, -> {order(:description)}

     #soobrescreve o metodo para transformar para url amigavel
    #def to_param
    #{}"#{id} #{description}".parameterize
    #end

end
