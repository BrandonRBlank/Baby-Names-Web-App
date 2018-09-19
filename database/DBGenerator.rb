
# Definetly not the best way to do this! Took 7 minutes and 14 seconds to make the database table! Haha
require 'sqlite3'

database = SQLite3::Database.new("../database/BabyNames.database")
database.execute("CREATE TABLE IF NOT EXISTS BabyNames (
                            id        INTEGER PRIMARY KEY,
                            name      STRING,
                            y1900     INTEGER,
                            y1910     INTEGER,
                            y1920     INTEGER,
                            y1930     INTEGER,
                            y1940     INTEGER,
                            y1950     INTEGER,
                            y1960     INTEGER,
                            y1970     INTEGER,
                            y1980     INTEGER,
                            y1990     INTEGER,
                            y2000     INTEGER );")

i = 0
File.open('names-data.txt', 'r').each do |names|
  t = Array.new
  first = true
  split = names.split(/[\s]/)
  split.each do |item|
    if first
      t << item
      first = false
      next
    end
    if item.to_i == 0
      item = 1001
      t << item
    else
      t << item
    end
  end
  database.execute("INSERT INTO BabyNames VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)",
                   i, t[0], t[1], t[2], t[3], t[4], t[5], t[6], t[7], t[8], t[9], t[10], t[11])
  i += 1
end