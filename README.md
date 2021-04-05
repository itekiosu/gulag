[![Discord](https://discordapp.com/api/guilds/804029976276893716/widget.png?style=shield)](https://iteki.pw/discord)

DISCLAIMER: gulag is still in a beta stage - the server is certainly getting quite
stable & useable now, but don't let it fool you too much.. there are still large
portions of the underlying systems that have yet to be implemented completely correctly.

gulag is cmyui's implementation of an osu! server's backend (bancho protocol, /web endpoints,
avatars/assets, and a devevloper rest api) edited for use on Iteki. it's designed for relatively experienced devs
looking for an osu! server with more bells and whistles than many other implementations.


Installation Guide
-------------
important notes:
- ubuntu 20.04 & nginx have unknown issues? i recommend using 18.04
- we have an extremely different infrastructure to cmyui's repo so if you're using anything from his src then don't use this
```sh
# add ppa for py3.9 (required since it's new)
sudo add-apt-repository ppa:deadsnakes/ppa

# install requirements (py3.9, mysql, nginx, build tools)
sudo apt install python3.9 python3.9-dev python3.9-distutils \
                 mysql-server nginx build-essential

# install pip for py3.9
wget https://bootstrap.pypa.io/get-pip.py
python3.9 get-pip.py && rm get-pip.py

# clone the repo & init submodules
git clone https://github.com/itekiosu/gulag.git && cd gulag
git submodule init && git submodule update

# install gulag requirements w/ pip
python3.9 -m pip install -r ext/requirements.txt

# build oppai-ng's binary
cd oppai-ng && ./build && cd ..

######################################
# NOTE: before continuing, create an #
# empty database in mysql for gulag  #
######################################

# import gulag's mysql structure
mysql -u your_sql_username -p your_db_name < ext/db.sql

# copy our nginx config to `sites-enabled` & open for editing
sudo ln ext/nginx.conf /etc/nginx/sites-enabled/gulag.conf
sudo nano /etc/nginx/sites-enabled/gulag.conf

##########################################
# NOTE: before continuing, make sure you #
# have completely configured the file.   #
##########################################

# reload the reverse proxy's config
sudo nginx -s reload

# copy our gulag config to cwd & open for editing
cp ext/config.sample.py config.py
nano config.py

##########################################
# NOTE: before continuing, make sure you #
# have completely configured the file.   #
##########################################

# start the server
./gulag.py
```

Directory Structure
------
    .
    ├── constants  # code representing gamemodes, mods, privileges, and other constants.
    ├── ext        # external files from gulag's primary operation.
    ├── objects    # code for representing players, scores, maps, and more.
    ├── utils      # utility functions used throughout the codebase for general purposes.
    └── domains    # the route-continaing domains accessible to the public web.
        ├── cho    # (ce|c4|c5|c6).ppy.sh/* routes (bancho connections)
        ├── osu    # osu.ppy.sh/* routes (mainly /web/ & /api/)
        └── ava    # a.ppy.sh/* routes (avatars)
