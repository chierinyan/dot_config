#!/usr/bin/env python3
import os, sys, glob, shutil
from mutagen.flac import FLAC
from mutagen.mp4 import MP4

import tempfile, yaml
from subprocess import call

EDITOR = os.environ.get('EDITOR', 'vi')

base = sys.argv[1]
audios = []
for file in glob.glob(base+'/*.flac'):
    if os.stat(file).st_nlink != 1:
        shutil.copy(file, file+'.tmp')
        os.replace(file+'.tmp', file)
    audio = FLAC(file)
    audios.append(audio)

for file in glob.glob(base+'/*.m4a'):
    audio = MP4(file)
    audios.append(audio)

tracks = []
album = {'album': [''], 'albumartist': [''], 'date': [''], 'discnumber': ['1'], 'tracks': tracks}
if 'album' in audios[0]:
    album['album'] = audios[0]['album']
if 'albumartist' in audios[0]:
    album['albumartist'] = audios[0]['albumartist']
if 'date' in audios[0]:
    album['date'][0] = audios[0]['date'][0][:10]
if 'discnumber' in audios[0]:
    album['discnumber'] = audios[0]['discnumber']

dump = ['lyrics', 'album', 'albumartist', 'genre', 'copyright', 'description', 'comment', 'comments', 'performer', 'mood', 'genrenumber', 'date']
for i in range(len(audios)):
    metadata = dict(audios[i])
    keys = tuple(metadata.keys())
    for key in keys:
        if key in dump or len(key) == 36:
            del metadata[key]
            continue
        if key == 'artist':
            metadata[key][0] = metadata[key][0].replace('&', '、')
        metadata[key][0] = metadata[key][0].replace('：', ':')
        metadata[key][0] = metadata[key][0].replace('（', '(')
        metadata[key][0] = metadata[key][0].replace('）', ')')
        metadata[key][0] = metadata[key][0].replace('/', '／')
    tracks.append(metadata)

with tempfile.NamedTemporaryFile(mode='w+', suffix='.yaml') as tf:
    yaml.dump(dict(album), tf,
              width=1024, allow_unicode=True, default_style="'", default_flow_style=False)
    tf.flush()

    call([EDITOR, tf.name])

    tf.seek(0)
    modified = yaml.safe_load(tf)
    if not modified:
        print("Nothing to do")
        exit(0)
    modified_tracks = modified['tracks']

for i in range(len(audios)):
    audios[i].delete()
    audios[i].update(modified_tracks[i])
    audios[i]['album'] = modified['album']
    audios[i]['albumartist'] = modified['albumartist']
    audios[i]['date'] = modified['date']
    audios[i]['discnumber'] = modified['discnumber']
    audios[i].save()
    new_name = f'{audios[i]["discnumber"][0]}-{audios[i]["tracknumber"][0]:0>2}-{modified_tracks[i]["title"][0]}.flac'
    if new_name != audios[i].filename:
        os.rename(audios[i].filename, base+'/'+new_name)

new_base = modified['albumartist'][0] + ' - ' + modified['album'][0].replace(' / ', '／')
if base != new_base:
    os.rename(base, new_base)
