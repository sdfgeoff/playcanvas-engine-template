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
file_name = file_name.split('.')[0]

path_data = {
    'name': file_name,
    'mesh': os.path.join(bin_dir, 'Meshes'),
    'mat': os.path.join(bin_dir, 'Materials'),
    'img': os.path.join(bin_dir, 'Textures'),
}

export.do_export(None,
    path_data,
    True
)
