class Player

  attr_accessor :token, :type, :name

  def initialize(name, token, type)
    @name = name
    @token = token
    @type = type
  end

end

