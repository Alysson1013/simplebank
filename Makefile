postgres:
	docker run --name postgres16 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres

createdb: 	
	docker exec -it postgres16 createdb --owner=root simple_bank

dropdb: 	
	docker exec -it postgres16 dropdb

migrateup: 
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown: 
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc: 
	sqlc generate

.PHONY: postgres createdb dropdb migrateup migratedown sqlc