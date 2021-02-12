# Export over http (apache2), the Lyon city 3DTiles tilesets.
# Refer to index.html for details on content.
#
# In order to build and run:
#   docker build -t lyon-tileset-server .
#   docker run -p 8080:80 -t lyon-tileset-server
# and then open http://localhost:8080 with your browser

FROM ubuntu:16.04

RUN apt-get update

# To avoid exposing root owned data
RUN useradd -m -d /home/tiles_user tiles_user

### Copy the data to tiles_user's PublishedData home sub-directory
RUN apt-get -y install wget
RUN cd /home/tiles_user                                           && \
    wget  --recursive --no-parent --no-host-directories              \
      http://rict.liris.cnrs.fr/DataStore/TileSet_Lyon_2009_full/ && \ 
    wget  --recursive --no-parent --no-host-directories              \
      http://rict.liris.cnrs.fr/DataStore/TileSet_Lyon_2012_full/ && \
    wget  --recursive --no-parent --no-host-directories              \
    http://rict.liris.cnrs.fr/DataStore/TileSet_Lyon_2015_full/   && \
    mv DataStore PublishedData
COPY index.html                     /home/tiles_user/PublishedData
COPY logo-imu.png                   /home/tiles_user/PublishedData
COPY logo-liris.png                 /home/tiles_user/PublishedData
COPY logo-smart-data-grand-lyon.png /home/tiles_user/PublishedData

# The http server
RUN apt-get -y install apache2

# Remove the default server to avoid collisions (this file is a symlink anyhow)
RUN rm /etc/apache2/sites-enabled/000-default.conf
COPY threedtilesets.alpha.grandlyon.com.apache2.conf \
     /etc/apache2/sites-available/
# Enable the associated virtual site
RUN a2ensite threedtilesets.alpha.grandlyon.com.apache2.conf

CMD ["apache2ctl", "-D", "FOREGROUND"]

EXPOSE 80
