#encoding: UTF-8
namespace :set do
  desc "Crea 3 usuarios: S-Admin, Admin y Cliente"
  task :users => :environment do 
    Rake::Task['db:reset'].invoke
    Usuario.create(
      :login    => "S-Admin", 
      :password => "12345678", 
      :email    => "s-admin@dominio.com", 
      :telefono => "12345678", 
      :admin    => 2, 
      :compania => "S-Administradora",
      :nombre   => "S-Admin",
      :apellido => "istrador"
    )
    Usuario.create(
      :login    => "Admin", 
      :password => "12345678", 
      :email    => "admin@dominio.com", 
      :telefono => "12345678", 
      :admin    => 1, 
      :compania => "Administradora",
      :nombre   => "Admin",
      :apellido => "istrador",
    )
    Usuario.create(
      :login    => "Cliente", 
      :password => "12345678", 
      :email    => "cliente@dominio.com", 
      :telefono => "12345678", 
      :admin    => 0, 
      :compania => "Alimentos X",
      :nombre   => "Cliente",
      :apellido => "la"
    )
  end
  
  desc "Crea 4 productos para el usuario de id 2"
  task :products => :environment do
    Producto.create(
      :registro_sanitario => "A-12.345",
      :alimento           => true,
      :nombre             => "Harina de Trigo",
      :marca              => "Harina Pan",
      :pais_elaboracion   => "VE",
      :fabricante         => "Fabricante X",
      :codigo_arancelario => "100.100",
      :usuario_id         => 3
    )
    Producto.create(
      :registro_sanitario => "L-12.346",
      :alimento           => false,
      :nombre             => "Ron Blanco",
      :marca              => "Santa Teresa",
      :pais_elaboracion   => "VE",
      :fabricante         => "Ron Santa Teresa",
      :codigo_arancelario => "100.101",
      :usuario_id         => 3
    )
    Producto.create(
      :registro_sanitario => "A-12.347",
      :alimento           => true,
      :nombre             => "Aceitunas rellenas con pimiento asado",
      :marca              => "Jolca",
      :pais_elaboracion   => "CO",
      :fabricante         => "Fabricante Y",
      :codigo_arancelario => "101.103",
      :usuario_id         => 3
    )
    Producto.create(
      :registro_sanitario => "L-12.348",
      :alimento           => false,
      :nombre             => "Whisky Dewards",
      :marca              => "Dewards",
      :pais_elaboracion   => "CO",
      :fabricante         => "Fabricante Y",
      :codigo_arancelario => "101.107",
      :usuario_id         => 3
    )
  end
  
  desc "Crea 3 usuarios y 4 productos para el usuario Cliente"
  task :database => [:users, :products]
end
