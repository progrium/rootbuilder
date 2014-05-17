
build: rootfs.tar Dockerfile
	docker build -t rootbuilder-example .

rootfs.tar:
	cd rootfs && docker build -t rootbuilder .
	docker run --rm rootbuilder > rootfs.tar
	docker rmi rootbuilder