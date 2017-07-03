require 'highline/import'
require 'mechanize'

# Grabbed from https://github.com/oti/slack-reaction-decomoji/blob/master/import.rb
module SlackBigEmoji
  class Uploader
    BASE_DIR = File.expand_path(File.dirname(__FILE__))

    def initialize(dir)
      @dir = dir
      @page = nil
      @agent = Mechanize.new
    end
    attr_accessor :page, :agent

    def upload_emojis
      move_to_emoji_page
      push_emojis
    end

    private

    def login
      team_name  = ask('Your slack team name (subdomain): ')
      email      = ask('Login email: ')
      password   = ask('Login password (hidden): ') { |q| q.echo = false }

      emoji_page_url = "https://#{team_name}.slack.com/admin/emoji"

      page = agent.get(emoji_page_url)
      page.form.email = email
      page.form.password = password
      @page = page.form.submit
    end

    def enter_two_factor_authentication_code
      page.form['2fa_code'] = ask('Your two factor authentication code: ')
      @page = page.form.submit
    end

    def move_to_emoji_page
      loop do
        if page && page.form['signin_2fa']
          enter_two_factor_authentication_code
        else
          login
        end

        break if page.title.include?('Emoji')
        puts 'Login failure. Please try again.'
        puts
      end
    end

    def push_emojis
      Dir.glob("#{@dir}/*.png").sort.each do |path|
        basename = File.basename(path, '.*')

        # skip if already exists
        next if page.body.include?(":#{basename}:")

        puts "importing #{basename}..."

        form = page.form_with(action: '/customize/emoji')
        form['name'] = basename
        form.file_upload.file_name = path
        @page = form.submit
      end
    end
  end
end
