require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'


class Main

  def initialize
    @stations = []
    @trains = []
    @routes = []  
  end

  def start
    loop do
      puts "Выберите действие:
        1 - Создать станцию
        2 - Создать поезд
        3 - Создать маршрут
        4 - Добавить станцию в маршрут
        5 - Удалить станцию из маршрута
        6 - Назначить маршрут поезду
        7 - Добавить вагон к поезду
        8 - Отцепить вагон от поезда
        9 - Переместить поезд вперед по маршруту
        10 - Переместить поезд назад по маршруту
        11 - Посмотреть список станций
        12 - Посмотреть список поездов на станции
        0 - Выход"

      action = gets.to_i

      break if action == 0 

      case action
        when 1
          create_station

        when 2
          puts "Введите тип поезда: 
          1 - Пассажирский
          2 - Грузовой"
          type = gets.to_i
          puts "Введите номер поезда: "
          number = gets.to_i
          if type == 1
            create_passenger_train(number)
          elsif type == 2
            create_cargo_train(number)
          else
            puts "Введите 1 или 2"            
          end

        when 3
          puts "Введите начальную станцию: "
          start = gets.chomp
          puts "Введите конечную станцию: "
          finish = gets.chomp
          create_route(start, finish)

        when 4
          station = choise_station
          route = choise_route
          route.add_station(station)

        when 5
          station = choise_station
          route = choise_route
          route.delete_station(station)

        when 6
          train = choise_train
          route = choise_route
          train.route=(route) #почему этот метод не работает?

        when 7
          train = choise_train
            if train.type == :passenger
              wagon = create_passenger_wagon
            else
              wagon = create_cargo_wagon                   
            end
          train.add_wagon(wagon)        

        when 8
          train = choise_train
          train.delete_wagon

        when 9
          train = choise_train
          train.go_forward

        when 10
          train = choise_train
          train.go_backward
          
        when 11
          @stations.each { |station| puts station.name }
          
        when 12
          station = choise_station
          puts "#{station.trains}" #тоже не работает
          
        else
          puts "Введите число от 0 до 12"
      end
    end  
  end

private #В private поместил методы, к которым нет необходимости обращаться напрямую

  def create_station
    puts "Введите название станции: "
    name = gets.chomp
    station = Station.new(name)
    @stations << station
  end

  def choise_station
    puts "Введите название станции"
    name = gets.chomp
    @stations.each { |station| station if station.name == name }   
  end

  def create_passenger_train(number)
    train = PassengerTrain.new(number)
    @trains << train
  end

  def create_cargo_train(number)
    train = CargoTrain.new(number)
    @trains << train
  end

  def choise_train
    puts "Введите номер поезда: "
    train_number = gets.to_i
    @trains.each { |train| train if train.number == train_number } 
  end

  def create_route(start, finish)
    route = Route.new(start, finish)
    @routes << route
  end

  def choise_route
    puts "Введите порядковый номер маршрута: "
    number = gets.to_i
    @routes[number - 1] 
  end

  def create_passenger_wagon
    wagon = PassengerWagon.new
  end

  def create_cargo_wagon
    wagon = CargoWagon.new
  end 
end

x = Main.new
x.start