#compiler c'est une alias du premier stage
FROM ubuntu AS compiler
COPY hello.c /
RUN apt-get update\
	 && apt-get install -y build-essential\
	 && make hello \
	 && apt-get -y remove build-essential \
	 && apt-get -y autoremove \ 
	 && rm -rf /var/lib/apt/* 
#le deuxieme stage
FROM ubuntu
#copier from du compiler le contenu du /hello dans le /hello du deuxieme stage
COPY --from=compiler /hello /hello
ENTRYPOINT ["/hello"]
#CMD /hello
