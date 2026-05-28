Treatment.destroy_all
Appointment.destroy_all
Pet.destroy_all
Owner.destroy_all
Vet.destroy_all
User.destroy_all

User.create!(
  first_name: "Admin",
  last_name: "Sistem",
  email: "adminsistem@vetclinic.com",
  password: "password123",
  role: :admin
)

Vet.create!(
  first_name: "Maria",
  last_name: "Correa",
  email: "maria@vet.com",
  specialization: "Cirugía"
)

Vet.create!(
  first_name: "Sebastian",
  last_name: "Ruiz",
  email: "seba@vet.com",
  specialization: "Dermatología"
)

u_vet_seb = User.create!(
  first_name: "Sebastian",
  last_name: "Ruiz",
  email: "sebastian.ruiz.vet@vetclinic.com",
  password: "password123",
  role: :vet
)

v2 = Vet.create!(
  first_name: "Sebastian", 
  last_name: "Ruiz", 
  email: "sebastian.ruiz.vet@clinic.com", 
  specialization: "Medicina General",
  user: u_vet_seb 
)

v1 = Vet.create!(
  first_name: "Maria", 
  last_name: "Correa", 
  email: "maria.correa.vet@clinic.com", 
  specialization: "Cirugía"
)

u_owner_pepito = User.create!(
  first_name: "Pepito",
  last_name: "Perez", 
  email: "pepitoperez@vetclinic.com",
  password: "password123",
  role: :owner
)

o1 = Owner.create!(
  first_name: "Pepito", 
  last_name: "Perez", 
  email: "pepitoperez@mail.com", 
  phone: "13579", 
  address: "Manuel Montt 123",
  user: u_owner_pepito 
)

o2 = Owner.create!(first_name: "Cristobal", last_name: "Colon", email: "cristobalcolon@mail.com", phone: "24680", address: "Conquistador de América 1492")
o3 = Owner.create!(first_name: "Miguel", last_name: "Cervantes", email: "miguelcervantes@mail.com", phone: "12345", address: "La Mancha 1010")

p1 = o1.pets.create!(name: "Firulais", species: "Dog", breed: "Quiltro", birth_date: "2020-02-20") # Ajusté date_of_birth a birth_date según tus modelos anteriores
p2 = o1.pets.create!(name: "Michi", species: "Cat", breed: "Persa", birth_date: "2024-04-24")
p3 = o2.pets.create!(name: "Zanahoria", species: "Rabbit", breed: "Cabeza de León", birth_date: "2022-02-22")
p4 = o3.pets.create!(name: "Bimbo", species: "Dog", breed: "Pastor Alemán", birth_date: "2019-09-19")
p5 = o3.pets.create!(name: "Garfield", species: "Cat", breed: "Exótico de Pelo Corto", birth_date: "2008-08-18")

begin
  p1.photo.attach(io: File.open(Rails.root.join('db/seeds/pets/dog.jpg')), filename: 'dog.jpg', content_type: 'image/jpeg')
  p2.photo.attach(io: File.open(Rails.root.join('db/seeds/pets/cat.jpg')), filename: 'cat.jpg', content_type: 'image/jpeg')
  p3.photo.attach(io: File.open(Rails.root.join('db/seeds/pets/bird.jpg')), filename: 'bird.jpg', content_type: 'image/jpeg')
rescue Errno::ENOENT, LoadError
  puts "Error, do it again"
end

a1 = Appointment.create!(pet: p1, vet: v1, date: DateTime.now - 2.days, reason: "Cirugía", status: :completed)
a2 = Appointment.create!(pet: p2, vet: v2, date: DateTime.now - 1.day, reason: "Chequeo", status: :completed)
a3 = Appointment.create!(pet: p3, vet: v2, date: DateTime.now + 1.day, reason: "Vacuna", status: :scheduled)
a4 = Appointment.create!(pet: p4, vet: v1, date: DateTime.now, reason: "Herida", status: :in_progress)
a5 = Appointment.create!(pet: p5, vet: v2, date: DateTime.now - 5.days, reason: "Control", status: :cancelled)

a1.treatments.create!(description: "Anestesia: Propofol 5mg. Sin complicaciones.")
a2.treatments.create!(description: "Desparasitación: Totalne 1 ml. Vía oral.")
a4.treatments.create!(description: "Limpieza con Suero y Antibiótico Amoxicilina 250mg.")
