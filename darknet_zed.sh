#!/bin/sh

BASEDIR=$(dirname "$0")

# darknet should be compiled with ZED-SDK
if [ ! -d ~/darknet -o ! -e ~/darknet/uselib ]; then
    echo "~/darknet directory doesn't exist. aborting."
    exit
fi

cp $BASEDIR/yolo/yolov3-artefact.cfg ~/darknet/
cd ~/darknet && mkdir -p backup

# download the weight file if it does not exist
if [ ! -e ./backup/yolov3-artefact_final.weights ]; then
    curl -o backup/yolov3-artefact_final.weights https://github.com/iomz/gserm19-adl/releases/download/v1/yolov3-artefact_final.weights
fi

LD_LIBRARY_PATH=./:/usr/local/cuda/lib64 ./uselib ~/artefact-data/obj.names yolov3-artefact.cfg backup/yolov3-artefact_final.weights zed_camera
