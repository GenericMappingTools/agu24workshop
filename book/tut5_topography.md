---
jupytext:
  formats: md:myst
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.16.4
kernelspec:
  display_name: Python 3
  language: python
  name: python3
---

# 3D Topography

In this tutorial, let's use PyGMT to create 3D perspective plots of Digital Elevation
Models (DEM) over Mars (the planet) and Antarctica (the continent)!

🔖 References:

- https://www.generic-mapping-tools.org/remote-datasets/mars-relief.html
- https://github.com/andrebelem/PlanetaryMaps
- {cite:t}`NeumannMarsOrbiterLaser2003`


```{code-cell}
import pygmt
```

# 0️⃣ Mars relief data

First, we'll load the Mars Orbiter Laser Altimeter (MOLA) dataset using
[`pygmt.datasets.load_mars_relief`](https://www.pygmt.org/v0.13.0/api/generated/pygmt.datasets.load_mars_relief.html).
The following command will load the MOLA dataset into an
[`xarray.DataArray`](https://docs.xarray.dev/en/v2024.09.0/generated/xarray.DataArray.html)
grid, and we'll set the `resolution` parameter to `01d` (1 arc-degree) for now.

```{code-cell}
da_mars = pygmt.datasets.load_mars_relief(resolution="01d")
da_mars
```

## 2D map view

Here we can create a map of the entire Martian surface, using a
[Mollweide projection](https://www.pygmt.org/v0.13.0/projections/misc/misc_mollweide.html).
To get a reddish hue, we'll use a
[colormap](https://docs.generic-mapping-tools.org/6.5/reference/cpts.html)
called `SCM/managua` which comes with a soft hinge
(see [`makecpt -C`](https://docs.generic-mapping-tools.org/6.5/makecpt.html#c))
that can be set at elevation 0 meter by appending `+h0` to the `cmap` parameter.

```{code-cell}
fig = pygmt.Figure()
fig.grdimage(grid=da_mars, frame=True, projection="W12c", cmap="SCM/managua+h0")
fig.colorbar(frame=["a5000", "x+lElevation", "y+lm"])
fig.show()
```

## Zoomed in view

A very interesting feature is [Olympus Mons](https://en.wikipedia.org/wiki/Olympus_Mons)
centered at approximately 19°N and 133°W, with a height of 22 km (14 miles) and
approximately 700 km (435 miles) in diameter.

Let's grab a higher resolution map over the volcano, and plot another 2D map!

```{code-cell}
da_olympus = pygmt.datasets.load_mars_relief(
    resolution="30s",  # 30 arc-seconds
    region=[-151, -117, 12, 25],  # xmin, xmax, ymin, ymax
)
da_olympus
```

```{code-cell}
fig = pygmt.Figure()
fig.grdimage(grid=da_olympus, frame=["WSne+tOlympus Mons", "af"], cmap="SCM/managua+h0")
fig.colorbar(frame=["a5000", "x+lElevation", "y+lm"])
fig.show()
```

# 1️⃣ Using `grdview` for 3D Visualization

The [`grdview`](https://www.pygmt.org/v0.13.0/api/generated/pygmt.Figure.grdview.html)
function in PyGMT is a powerful tool for creating 3D perspective views of gridded data.
By adjusting azimuth and elevation parameters, you can change the viewpoint, helping you
to highlight specific terrain features or data patterns. Let’s go through how these
parameters affect the visualization.

**Setting the Perspective: Azimuth and Elevation**

- **Azimuth** (`azimuth`): Controls the horizontal rotation of the view, ranging from 0°
  to 360°. Lower values (close to 0°) represent a viewpoint from the north, while 90°
  gives a view from the east, 180° from the south, and 270° from the west. Experimenting
  with azimuth can help showcase specific aspects of the data from different angles.
- **Elevation** (`elevation`): Controls the vertical angle of the view, with 90°
  representing a top-down perspective and lower values providing more of a side view.
  Typically, values between 20° and 60° create a balanced 3D effect.

**Example**: Using `perspective=[150, 45]` means `azimuth=150` and `elevation=45`, which
gives you a southeast view, tilted at a moderate angle to capture both horizontal and
vertical details.

```{code-cell}
fig = pygmt.Figure()

fig.grdview(
    grid=da_olympus,
    cmap="SCM/managua+h0",
    region=[-151, -117, 12, 25, -5000, 23000],  # xmin, xmax, ymin, ymax, zmin, zmax
    projection="M12c",
    perspective=[150, 45],  # azimuth bearing, and elevation angle
    zsize="4c",  # vertical exaggeration
    surftype="s",  # surface plot
    shading=True,
    frame=["xaf", "yaf", "z5000+lmeters"],
)

fig.colorbar(frame=["a5000", "x+lElevation", "y+lm"], perspective=True, shading=True)
fig.show()
```

Note that there are other things we have configured such as:

- **zsize** - vertical exaggeration as z-axis size, we used `4c` here for 4 centimeters
- **surftype** - using `s` will just create a regular surface
- **shading** - set to `True` to get the default hillshading effect
- **frame** - A proper 3D map frame that consists of:
  - automatic tick marks on x and y axis (e.g. `xaf` and `yaf`)
  - z-axis tick marks every 5000m, plus a label (`z5000+lLabel`)
