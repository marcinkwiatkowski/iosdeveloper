module IOSDeveloper

  class Profile

    def initialize(id, name, app_id, status, type)
      @id = id
      @name = name
      @app_id = app_id
      @status = status
      @type = type
    end

    attr_reader :id, :name, :app_id, :status, :type

  end

end
