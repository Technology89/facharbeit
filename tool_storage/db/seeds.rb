# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(name: "admin", password: "admin")

Employee.create(vorname: "Dennis", nachname: "Burat", personalnummer: "343")

Tool.create(hersteller: "Knipex", modell: "Seitenschneider klein", barcode: "3354965", lagerbestand: "153", mindestbestand: "10", anzahl_ersatz: "0")
Tool.create(hersteller: "Knipex", modell: "Seitenschneider groß", barcode: "3354966", lagerbestand: "15", mindestbestand: "2", anzahl_ersatz: "0")
Tool.create(hersteller: "Knipex", modell: "Spitzzange klein", barcode: "3354967", lagerbestand: "24", mindestbestand: "5", anzahl_ersatz: "0")
Tool.create(hersteller: "Knipex", modell: "Spitzzange groß", barcode: "3354968", lagerbestand: "33", mindestbestand: "5", anzahl_ersatz: "0")
Tool.create(hersteller: "Knipex", modell: "Schnabelzange klein", barcode: "3354969", lagerbestand: "17", mindestbestand: "5", anzahl_ersatz: "0")
Tool.create(hersteller: "Knipex", modell: "Schnabelzange groß", barcode: "3354970", lagerbestand: "25", mindestbestand: "5", anzahl_ersatz: "0")

Machine.create(hersteller: "Bosch", modell: "Bohrhammer SDS", barcode: "6364283", ausgeliehen: "false")
Machine.create(hersteller: "Dewalt", modell: "Akkuschrauber", barcode: "6364284", ausgeliehen: "false")
Machine.create(hersteller: "Bosch", modell: "Stichsäge", barcode: "6364285", ausgeliehen: "false")
