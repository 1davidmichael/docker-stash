FROM centos
MAINTAINER David Michael <1.david.michael@gmail.com>
ENV STASH_HOME /opt/atlassian-data
ENV STASH_INST /opt/atlassian-stash
RUN yum install -y git perl java tar
ADD http://www.atlassian.com/software/stash/downloads/binary/atlassian-stash-3.1.3.tar.gz /opt/atlassian-stash.tar.gz
RUN mkdir $STASH_INST
RUN tar xzvf /opt/atlassian-stash.tar.gz -C $STASH_INST --strip-components=1
VOLUME ["/opt/atlassian-data"]
EXPOSE 7990
CMD /usr/bin/java -Djava.util.logging.config.file=$STASH_INST/conf/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -XX:MaxPermSize=256m -Xms512m -Xmx768m -Djava.awt.headless=true -Dfile.encoding=UTF-8 -Datlassian.standalone=STASH -Dorg.apache.jasper.runtime.BodyContentImpl.LIMIT_BUFFER=true -Dmail.mime.decodeparameters=true -Dorg.apache.catalina.connector.Response.ENFORCE_ENCODING_IN_GET_WRITER=false -Djava.library.path=$STASH_INST/lib/native:/opt/$STASH_HOME/lib/native -Dstash.home=$STASH_HOME -Djava.endorsed.dirs=$STASH_INST/endorsed -classpath $STASH_INST/bin/bootstrap.jar:$STASH_INST/bin/tomcat-juli.jar -Dcatalina.base=$STASH_INST -Dcatalina.home=$STASH_INST -Djava.io.tmpdir=$STASH_INST/temp org.apache.catalina.startup.Bootstrap start 
