namespace :utils do
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

  task generate_ads: :environment do

    puts "Cria Anúncios Fake"

    100.times do
    Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description:LeroleroGenerator.paragraph(Random.rand(3)),
        member: Member.all.sample,
        category:  Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}"
        )
    end

        puts "Anúncios cadastrados com sucesso!"
  end

end
 