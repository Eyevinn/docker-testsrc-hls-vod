#!/bin/sh

ffmpeg -y -re -i https://download.blender.org/durian/trailer/sintel_trailer-1080p.mp4 \
  -preset slow -g 48 -sc_threshold 0 \
  -map 0:0 -map 0:1 -map 0:0 -map 0:1 \
  -s:v:0 640x360 -c:v:0 libx264 -b:v:0 365k \
  -s:v:1 960x540 -c:v:1 libx264 -b:v:1 2000k  \
  -c:a copy \
  -var_stream_map "v:0,a:0 v:1,a:1" \
  -master_pl_name master.m3u8 \
  -f hls -hls_time 4 -hls_playlist_type vod -hls_flags round_durations+program_date_time \
  -hls_segment_filename "/data/vod/v%v/fileSequence%d.ts" /data/vod/v%v/media.m3u8

cd /data/ && python -m http.server ${PORT:-8080}
