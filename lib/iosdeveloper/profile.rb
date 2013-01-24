module IOSDeveloper

  class Profile

    def initialize(name, app_id, status, type, download_url)
      @name = name
      @app_id = app_id
      @status = status
      @type = type
      @download_url = download_url
    end

    attr_reader :name, :app_id, :status, :type, :download_url

  end

end
