# GlTF lib for Python

3D Tiles use glTF to store their geometry. [Py3DTiles](https://gitlab.com/Oslandia/py3dtiles) cerates this glTF part, but using a glTF library would ensure better support for glTF writing and glTF extensions. [An issue exists on Py3DTiles about this survey](https://gitlab.com/Oslandia/py3dtiles/-/issues/184).

## glTF_Blender_IO

[glTF_Blender_IO](https://github.com/KhronosGroup/glTF-Blender-IO) is a Python library made for Blender by Khronos Group. It completely supports glTF export and import.

Pros:

- Made by Khronos Group, the consortium behind glTF standard
- Complete support of glTF extensions (standard and user extensions)
- Supports Draco compression

Cons:

- Not packaged the be used in a Python project (it means we cant pip install it)
- Only works with Python 3.10 (the Python version currently used by Blender)
- The API is a bit tricky if we use it in pure Python (since it's supposed to be used through Blender UI)
- Lack of documentation

### Make glTF_Blender_IO a package

I tried to create a `setup.py` so glTF_Blender_IO came become a package. Here's the content of the file:

```py
import os

from setuptools import find_packages, setup

here = os.path.abspath(os.path.dirname(__file__))

requirements = (
    "bpy"
)

setup(
    name="gltf_blender_io",
    python_requires="==3.10",
    packages=find_packages(),
    install_requires=requirements,
    entry_points={
        "console_scripts": ["test_lib=addons.io_scene_gltf2.io:main"],
    },
    zip_safe=False,  # zip packaging conflicts with Numba cache (#25)
)
```

`bpy` exists on pip but can be installed only with Python 3.10

### Small example

Small example using glTF_Blender_IO as a package, assuming the Python file is located at `gltf_Blender_IO/addons/io`:

```py
from .imp.gltf2_io_gltf import glTFImporter
from .exp.gltf2_io_export import save_gltf
from ..blender.com.gltf2_blender_json import BlenderJSONEncoder

def main():
    importer = glTFImporter("./my_model.glb", {"import_user_extensions": []})
    importer.read()
    print(importer.data.to_dict())
    print(bytes(importer.glb_buffer))

    save_gltf(importer.data.to_dict(), {
        "gltf_format": 'GLB',
        "gltf_filepath": './test.glb',
        "gltf_user_extensions": []
    }, BlenderJSONEncoder, importer.glb_buffer)
```

### Conclusion

Even if gltf_Blender_IO has the best support for glTF and its extensions in Python, the lib isn't designed to be used in a Python package. The API isn't dev friendly (no doc, tricky imports and arguments) and `bpy` limits the Python version. GlTf_Blender_IO would require some refactos and contributions before we could use it as a package in Py3DTiles.

## Pygltflib
