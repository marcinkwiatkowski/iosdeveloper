require "mechanize"

module IOSDeveloper

  class ProvisioningPortal

    DEVICES_URL = "https://developer.apple.com/ios/manage/devices/index.action"
    PROFILES_URL = "https://developer.apple.com/ios/manage/provisioningprofiles/index.action"
    DISTRIBUTION_PROFILES_URL = "https://developer.apple.com/ios/manage/provisioningprofiles/viewDistributionProfiles.action"
    ADD_DEVICE_URL = "https://developer.apple.com/ios/manage/devices/add.action"

    def initialize (login, password, team_name)
      @agent = Mechanize.new
      @username = login
      @password = password
      @team_name = team_name
    end

    def get_page url
      page = @agent.get(url)
      login_form = page.form_with(:name => 'appleConnectForm')
      if login_form
        login(login_form)
        page = @agent.get(url)
      end
      team_select_form = page.form_with(:name => 'saveTeamSelection')
      if team_select_form
        page = select_team(team_select_form)
      end
      page
    end

    def select_team(form)
      team_list = form.field_with(:name => 'memberDisplayId')
      if @team_name.nil? || @team_name == ''
        team_option = team_list.options.first
      else
        team_option = team_list.option_with(:text => @team_name)
      end
      puts "Selecting team '#{team_option.text}'."
      team_option.select
      form.click_button(form.button_with(:name => 'action:saveTeamSelection!save'))
    end

    def login(form)
      puts "Logging in with Apple ID '#{@username}'."
      form.theAccountName = @username
      form.theAccountPW = @password
      form.submit
    end

    def list_devices
      page = get_page(DEVICES_URL)
      page.search("#removeDevice table tbody tr").map do |item|
        device_name = item.at(".name span").text
        device_id = item.at(".id").text
        "#{device_name} - #{device_id}"
      end
    end

    def add_device(name, id)
      page = get_page(ADD_DEVICE_URL)

      form = page.form_with(:name => 'add')
      form["deviceNameList[0]"] = name
      form["deviceNumberList[0]"] = id
      page = form.submit

      error_message = page.search(".errorMessage li span")
      raise error_message.text unless error_message.empty?
      puts "Added device: #{id}"
    end

    def list_profiles
      get_development_profiles + get_distribution_profiles
    end

    def get_development_profiles
      get_profiles(PROFILES_URL, 'development')
    end

    def get_distribution_profiles
      get_profiles(DISTRIBUTION_PROFILES_URL, 'distribution')
    end

    def get_profiles(url, type)
      page = get_page(url)
      page.search("#remove table tbody tr").map do |item|
        name = item.at(".profile span").text
        app_id = item.at(".appid").text
        status = item.at(".statusXcode").child.text.strip
        Profile.new(name, app_id, status, type)
      end
    end

    def download_profile(profile_name, file_name)
      page = get_page(PROFILES_URL)
      page.search("#remove table tbody tr").each do |item|
        name = item.at(".profile span").text
        if name == profile_name
          download_link = item.at(".action a").attr("href")
          @agent.get(download_link).save(file_name)
          puts "Saved #{profile_name} profile in #{file_name}"
        end
      end
    end

  end

end