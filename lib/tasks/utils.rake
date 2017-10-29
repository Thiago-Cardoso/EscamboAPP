namespace :utils do

###########################################################
   desc "Setup Development"
   task setup_dev: :environment do
    images_path = Rails.root.join('public', 'system')
    puts "Executando o setup para desenvolvimento..."

    puts "APAGANDO BD... #{%x(rake db:drop)}"
    puts "APAGANDO imagens de public/system #{%x(rm -rf #{images_path})}"
    puts "CRIANDO BD... #{%x(rake db:create)}"
    %x(rake db:migrate)
    %x(rake db:seed)
    %x(rake utils:generate_admins)
    %x(rake utils:generate_members)
    %x(rake utils:generate_ads)

     puts "Setup completado com sucesso..."
  end

#########################################################
  desc "Cria Administradores Fakes"
  task generate_admins: :environment do

    puts "Cadastrando ADMINISTRADORES..."

    10.times do
    Admin.create!(email: Faker::Internet.email,
                  name: Faker::Name.name ,
                  password: "123456", 
                  password_confirmation: "123456",
                  role: [0,1].sample 
                  )
    end

    puts "ADMINISTRADORES cadastrados com sucesso!"
  end

###########################################################

  desc "Cria Membros Fakes"
  task generate_members: :environment do

    puts "Cadastrando MEMBROS..."

    10.times do
    Member.create!(email: Faker::Internet.email,
                  password: "123456", 
                  password_confirmation: "123456"
                  )
    end

    puts "MEMBROS cadastrados com sucesso!"
  end


############################################################
  task generate_ads: :environment do

    puts "Cria Anúncios Fake"

    100.times do
    Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description:LeroleroGenerator.paragraph([1,2,3].sample),
        member: Member.all.sample,
        category:  Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        finish_date: Date.today + Random.rand(90),
        picture: File.new(Rails.root.join('public', 'templates', 'images-for-ads', "#{Random.rand(9)}.jpg"), 'r')
        )
    end

        puts "Anúncios cadastrados com sucesso!"
  end

end
 