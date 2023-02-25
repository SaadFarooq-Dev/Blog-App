# README
Project's Title:
  Blog App.

Project Description:
A blog where users can publish there blogs and also communicate with other bloggers as well. Users can Comment and like other blogs as well.
This appllication was build using Ruby on Rails.

1. Ruby Version:
    - ruby '2.7.2'
2. Rails Version:
    - rails '5.2'
3. System Dependencies:
  - postgresql   1.4.3
  - Sass Rails =>1.3 < 3
  - uglifier     4.2.0
  - coffe-rails  4.2
  - turbilinks   5.2.1
  - actiontext   0.1.0
  - bootsnap     1.13.0
  - devise       4.8.1
  - faker        2.22.0
  - image_processing  1.12.2
  - webpacker ~> 5.x
  - cloudnairy   1.23.0
  - pundit       2.2.0
  - rails_admin  2.2.1
  - bootstrap    5.2
  

4. Project Setup: 
  - Install a IDE
  - Clone the repository
  - Install Git
  - Install RVM
  - gem install bundler
  - Install ruby 2.7 using rvm install 2.7
  - Install Postgres and PGAdmin4
  - Install Rails 5.2 gem
  - Intall the Given Dependencies/gems using bundler.
  - run bundle install in your rails project directory.
5. Configuration:
   - Database creation & initialization:
      - Start Postgresql sudo service postgresql start
      - Check Status of Postgresql sudo service postgresql status
      - use sudo -u postgres psql postgres to setup user postgresql username and password
      - Setup your PGAdmin4. you can follow the setup instruction from there offical website
      - Find the postgres.conf and change the isten_addresses = '*'
      - Find the pg_hba.conf and change the from: 
        - local      all           postgres              peer
        - to
        - local      all           postgres              md5
      - Run rails db:create from terminal
      - Run rails db:migrate to setup the database
      - Run rails db:seed to seed data for your use
      - For Production locally Enviroment:
      - Run RAILS_ENV=production rake db:create db:migrate db:seed
      - Run rake secret
      - Run export SECRET_KEY_BASE=output-of-rake-secret
      - config.assets.compile = false to config.assets.compile = true in production.rb
      - PreCompile Your Assets using RAILS_ENV=production bundle exec rake assets:precompile
   - Cloudnairy Setup:
      - Create a new Acoount on Cloudnairy
      - Click on the SDK Configuration and Choose Rails from there
      - Copy the Development and production settings from the configuration in cloudnairy
      - Create cloudnairy.yml file in the config directory and paste the configurations
      - In both development and production mode change the   
      - config.active_storage.service = :local to   config.active_storage.service = :cloudinary
   - SMTP Setup:
      - Add config.action_mailer.default_url_options = { host: 'localhost', port: 3000 } in the development.rb
      - Add config.action_mailer.default_url_options = { host: 'HOSTNAME', port: 3000 } in the production.rb where Hostname is your website hostname 
      - In development.rb and production.rb change the 
      - domain: 'gmail.com for production and localhost:3000 for development',
      - user_name: Your gmail email
      - password: your account app specific passowrd craeted from settings
    - Credential Files:
       - Make a new Credential File in Rails by editing it using your own choice of Editor. Run EDITOR='code --wait' rails credentials:edit
    - Heroku Setup
       - Create a new Account on Heroku
       - Connect your terminal to heroku using heroku login
       - Create a new App on heroko
       - Connect your Github to heroko
       - Change the stack of heroku from 22 to 20 from terminal for you given app
       - Migrate your Database to Heroku using Heroku run raild db:migrate
       - Deply Your App to Heroku by selecting the branch your repo that you want to publish
       - Using Heroku Console you can change you right from user to admin.
