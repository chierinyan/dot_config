#!/usr/bin/env python3

import argparse
import tempfile, yaml
import os, glob, pathlib
from subprocess import call

EDITOR = os.environ.get('EDITOR', 'vi')

parser = argparse.ArgumentParser()
parser.add_argument('-r', action='store_true')
parser.add_argument('-p', default='*')
args = parser.parse_args()

glob_pattern = args.p
if args.r:
    glob_pattern = '**/'+glob_pattern
original = sorted(glob.glob(glob_pattern, recursive=True, include_hidden=True))
original = {f'{i:0>4}':n for i,n in enumerate(original)}

with tempfile.NamedTemporaryFile(mode='w+', suffix='.yaml') as tf:
    yaml.dump(original, tf,
              width=1024, allow_unicode=True, default_style="'", default_flow_style=False)
    tf.flush()

    call([EDITOR, tf.name])

    tf.seek(0)
    modified = yaml.safe_load(tf)


for i in original:
    if i not in modified:
        pathlib.Path('tmp/'+os.path.dirname(original[i])).mkdir(parents=True, exist_ok=True)
        os.rename(original[i], f'tmp/{original[i]}')
    elif original[i] != modified[i]:
        os.rename(original[i], modified[i])
