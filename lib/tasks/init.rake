namespace :db do
  desc "Fill database with initial user"
  task init: :environment do
    # 创建管理用户
    User.create!(name: "LinuxNerd",
                email: "lwc_evale@hotmail.com",
                password: "qwe123",
                password_confirmation: "qwe123",
                admin: true)
  end
end