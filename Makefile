
build:
	docker build -t rootbuilder .

release:
	docker tag rootbuilder progrium/rootbuilder
	docker push progrium/rootbuilder