FROM python:2.7

ENV workdir /test

WORKDIR ${workdir}
ADD index.html ${workdir}/
EXPOSE 8080

CMD [ "python", "-m", "SimpleHTTPServer", "8080" ]