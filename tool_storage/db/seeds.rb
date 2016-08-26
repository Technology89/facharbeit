# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Tool.create(Hersteller: "Knipex", Modell: "Seitenschneider klein", Barcode: "00354965", Lagerbestand: "153", Mindestbestand: "10")
Tool.create(Hersteller: "Knipex", Modell: "Seitenschneider groß", Barcode: "00354966", Lagerbestand: "15", Mindestbestand: "2")
Tool.create(Hersteller: "Knipex", Modell: "Spitzzange klein", Barcode: "00354967", Lagerbestand: "24", Mindestbestand: "5")
Tool.create(Hersteller: "Knipex", Modell: "Spitzzange groß", Barcode: "00354968", Lagerbestand: "33", Mindestbestand: "5")
Tool.create(Hersteller: "Knipex", Modell: "Schnabelzange klein", Barcode: "00354969", Lagerbestand: "17", Mindestbestand: "5")
Tool.create(Hersteller: "Knipex", Modell: "Schnabelzange groß", Barcode: "00354970", Lagerbestand: "25", Mindestbestand: "5")

Machine.create(Hersteller: "Bosch", Modell: "Bohrhammer SDS", Barcode: "00364283", Ausgeliegen: "true", Ausgeliehen_seit: "2016-03-03")
Machine.create(Hersteller: "Dewalt", Modell: "Akkuschrauber", Barcode: "00364284", Ausgeliegen: "false", Ausgeliehen_seit: "")
Machine.create(Hersteller: "Bosch", Modell: "Stichsäge", Barcode: "00364285", Ausgeliegen: "false", Ausgeliehen_seit: "")
