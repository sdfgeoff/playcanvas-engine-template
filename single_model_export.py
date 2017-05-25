'''
This file gets run from command line and is injected into blender.
It has to run the export script such that it outputs models/images
into the right place
'''

import os
import sys
import bpy

project_dir = os.path.dirname(os.path.realpath(__file__))
sys.path.append(os.path.join(project_dir, 'lib/playcanvas-blender-tools'))

import export

bin_dir = os.path.join(project_dir, 'bin')
file_name = os.path.split(bpy.context.blend_data.filepath)[-1]
file_name = file_name.split('.')[0] + '.json'
export.do_export(None,
    os.path.join(bin_dir, file_name),
    os.path.join(bin_dir, './Meshes'),
    os.path.join(bin_dir, './Materials'),
    os.path.join(bin_dir, './Textures')
)
