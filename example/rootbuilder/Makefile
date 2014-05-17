
build:
	docker build -t example-rootbuilder .
	docker run --rm example-rootbuilder > ../rootfs.tar
	docker rmi example-rootbuilder