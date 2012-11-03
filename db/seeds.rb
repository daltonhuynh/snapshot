cities = [
  {
    name: "Tokyo",
    channel: "/instagram/tokyo",
    timezone: "Tokyo",
    lat: 35.6639824,
    lng: 139.6979483
  },
  {
    name: "London",
    channel: "/instagram/london",
    timezone: "London",
    lat: 51.5,
    lng: -0.116667
  },
  {
    name: "Seoul",
    channel: "/instagram/seoul",
    timezone: "Seoul",
    lat: 37.52555763195682,
    lng: 126.89603872832026
  },
  {
    name: "Barcelona",
    channel: "/instagram/barcelona",
    timezone: "Madrid",
    lat: 41.3833333,
    lng: 2.1833333
  },
  {
    name: "Paris",
    channel: "/instagram/paris",
    timezone: "Paris",
    lat: 48.856614,
    lng: 2.3522219000000177
  },
  {
    name: "Hong Kong",
    channel: "/instagram/hongkong",
    timezone: "Hong Kong",
    lat: 22.308949704932253,
    lng: 114.17206757189945
  },
  {
    name: "Sydney",
    channel: "/instagram/sydney",
    timezone: "Sydney",
    lat: -33.87450614611673,
    lng: 151.20980784340827
  },
  {
    name: "Seattle",
    channel: "/instagram/seattle",
    timezone: "Pacific Time (US & Canada)",
    lat: 47.6062095,
    lng: -122.3320708
  },
  {
    name: "Las Vegas",
    channel: "/instagram/lasvegas",
    timezone: "Pacific Time (US & Canada)",
    lat: 36.114615,
    lng: -115.172832
  },
  {
    name: "Rio",
    channel: "/instagram/rio",
    timezone: "Brasilia",
    lat: -22.887725595413666,
    lng: -43.23739604306638
  },
  {
    name: "Abu Dhabi",
    channel: "/instagram/abudhabi",
    timezone: "Abu Dhabi",
    lat: 24.459983,
    lng: 54.375522
  }
]

cities.each do |city_args|
  city = City.find_or_create_by(name: city_args[:name])
  city.update_attributes!(city_args)
end