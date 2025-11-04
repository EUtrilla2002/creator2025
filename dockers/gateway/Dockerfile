
FROM ubuntu:24.04

ENV TZ=Europe/Madrid
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

EXPOSE 8080

WORKDIR /

RUN apt update && apt-get install -y \
        sudo \
        wget \
        curl \
        lynx \
        git \
        vim \
        aha \
        7zip \
        unrar \
        zip \
        unzip

RUN apt update && apt-get install -y \
        nodejs \
        npm

#Install Python 3.9
RUN apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa -y && \
    apt-get update && apt-get install -y python3.9 python3.9-venv python3.9-distutils python3.9-dev python3-pip && \
    ln -sf /usr/bin/python3.9 /usr/bin/python3 && \
    python3 --version


#Espressif dependencies install
RUN apt update && apt-get install -y \
        build-essential \
        python3.9-dev \
        git \
        wget \
        flex \
        bison \
        gperf \
        cmake ninja-build \
        ccache \
        libffi-dev \
        libssl-dev \
        dfu-util \
        libusb-1.0-0 \
        rustc \
        cargo

#Espressif drivers install
RUN mkdir -p /esp && \
        cd /esp && \
        git clone -b v5.3.2 --recursive https://github.com/espressif/esp-idf.git && \
        cd /esp/esp-idf && \
        ./install.sh all && \
        pip3 uninstall click --break-system-packages && \
        pip3 install click==8.1.7 --break-system-packages


#Download CREATOR
RUN git clone https://github.com/creatorsim/creator.git && \
    cd creator && \
    npm install terser jshint colors yargs readline-sync && \
    ./mk_min.sh


#Gateway environment setup
ARG TARGET_BOARD=esp32c3 //Default value provided

RUN apt-get remove -y python3-blinker
# Debug options
RUN python3.9 -m pip install --upgrade --ignore-installed pip setuptools wheel


RUN python3.9 -m pip install --no-cache-dir --ignore-installed --force-reinstall --upgrade \
    cffi==1.15.1 cryptography==41.0.4


RUN python3.9 -m pip install --no-cache-dir --force-reinstall \
    eventlet==0.33.3 gdbgui==0.15.2.0 flask flask_cors flask-socketio   

RUN mv /creator/gateway/${TARGET_BOARD}.zip . && \
        unzip ${TARGET_BOARD}.zip && \
        mv ${TARGET_BOARD} drivers && \
        rm -f ${TARGET_BOARD}.zip


#Run web service
COPY start_gateway.sh .
CMD ["/usr/bin/sleep","infinity"]