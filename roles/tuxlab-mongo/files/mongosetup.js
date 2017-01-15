db.createCollection("courses")
db.createCollection("users")
db.createCollection("course_records")

db.users.createIndex( { "email" : 1 } )
