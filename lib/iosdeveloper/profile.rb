module IOSDeveloper

  class Profile

    def initialize(name, app_id, status, type)
      @name = name
      @app_id = app_id
      @status = status
      @type = type
    end

    attr_reader :name, :app_id, :status, :type

  end

end
