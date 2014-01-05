class Statistic
  attr_accessor :model1, :model2, :type


  #Initialize object
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end


  def get_class_instance
    begin
      class1 = Object.const_get self.model1
      class2 = Object.const_get self.model2
    rescue Exception => e
      puts "#{ e } (#{ e.class })"
    end
    return [class1, class2]
  end
end
