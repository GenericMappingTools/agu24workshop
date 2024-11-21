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

# 3D Topography 🏔️

In this tutorial, let's use PyGMT to create 3D perspective plots of Digital Elevation
Models (DEM) over Mars (the planet) and Antarctica (the continent)!

🔖 References:

- https://www.generic-mapping-tools.org/remote-datasets/mars-relief.html
- https://github.com/andrebelem/PlanetaryMaps
- {cite:t}`NeumannMarsOrbiterLaser2003`


```{code-cell}
import pygmt
import rioxarray
import rioxarray.merge
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

```{tip}
 When choosing azimuth and elevation, always consider how the scene is illuminated. Azimuth angles that align with typical light directions (e.g., from the northwest) often provide the most natural and visually appealing shadows. Elevations between 20° and 45° typically create a good balance, highlighting terrain features without flattening or obscuring them. You can experiment with different combinations to best reveal the data's structure.
```

# 2️⃣ Antarctic Digital Elevation Model

For the next exercise, we'll pay a visit to the Antarctic continent, specifically,
looking at Ross Island where the McMurdo Station (US) and Scott Base (NZ) is located.
We'll learn how to drape some RGB imagery from Sentinel-2 onto some DEM tiles from the
Reference Elevation Model of Antarctica (REMA).

🔖 References:
- https://www.pgc.umn.edu/data/rema/
- {cite:t}`HowatReferenceElevationModel2019`

## Getting a DEM mosaic

The REMA tiles are distributed as several GeoTIFF files. Our area of interest over Ross
Island spans two tiles, so we'll need to retrieve them both an mosaic them. There are
several sources for REMA, but we'll use one sourced from
https://registry.opendata.aws/pgc-rema/. The two specific tiles we'll get can be
previewed at:

- https://polargeospatialcenter.github.io/stac-browser/#/external/pgc-opendata-dems.s3.us-west-2.amazonaws.com/rema/mosaics/v2.0/32m/17_33/17_33_32m_v2.0.json
- https://polargeospatialcenter.github.io/stac-browser/#/external/pgc-opendata-dems.s3.us-west-2.amazonaws.com/rema/mosaics/v2.0/32m/17_34/17_34_32m_v2.0.json

```{tip}
To find the tile number, go to https://rema.apps.pgc.umn.edu/ and zoom/pan to the area
on the map you're interested in getting a DEM for. Click on the 'Identify' button on the
bottom left, and a pop-up will tell you the tile ID number.
```

To open the GeoTIFF files, we can use
[`rioxarray.open_rasterio`](https://corteva.github.io/rioxarray/stable/rioxarray.html#rioxarray.open_rasterio)
which load the data into an `xarray.DataArray`.

```{code-cell}
tile_17_33 = rioxarray.open_rasterio(
    filename="https://pgc-opendata-dems.s3.us-west-2.amazonaws.com/rema/mosaics/v2.0/32m/17_33/17_33_32m_v2.0_dem.tif"
)
tile_17_34 = rioxarray.open_rasterio(
    filename="https://pgc-opendata-dems.s3.us-west-2.amazonaws.com/rema/mosaics/v2.0/32m/17_34/17_34_32m_v2.0_dem.tif"
)
```

Next, we'll use
[`rioxarray.merge.merge_arrays`](https://corteva.github.io/rioxarray/stable/rioxarray.html#rioxarray.merge.merge_arrays)
to mosaic the two tiles together, and clip it to the spatial extent of Ross Island.

```{code-cell}
dem_mosaic = rioxarray.merge.merge_arrays(
    dataarrays=[tile_17_33, tile_17_34],
    bounds=(250_000, -1_370_000, 330_000, -1_300_000),  # xmin, ymin, xmax, ymax
).isel(band=0)
```

Preview the DEM using
[`pygmt.Figure.grdimage`](https://www.pygmt.org/v0.13.0/api/generated/pygmt.Figure.grdimage)

```{code-cell}
fig = pygmt.Figure()
fig.grdimage(grid=dem_mosaic, cmap="oleron", frame=True, shading=True)
fig.colorbar()
fig.show()
```

## Getting RGB imagery

Next, let's get some Sentinel-2 optical satellite imagery, which we'll use to drape
on top of the DEM later. We'll find some relatively cloud-free imagery that was taken on
31 Oct 2024, specifically these ones that can be previewed at:

- https://radiantearth.github.io/stac-browser/#/external/earth-search.aws.element84.com/v1/collections/sentinel-2-l2a/items/S2B_58CEU_20241109_0_L2A?.asset=asset-visual
- https://radiantearth.github.io/stac-browser/#/external/earth-search.aws.element84.com/v1/collections/sentinel-2-l2a/items/S2B_58CEV_20241109_0_L2A?.asset=asset-visual

```{tip}
There are several online viewers based on Spatiotemporal Asset Catalog (STAC) APIs that
allow you to search for satellite imagery. Some examples used here were:

- EO Browser: https://apps.sentinel-hub.com/eo-browser/?zoom=10&lat=-77.05481&lng=167.27783&themeId=DEFAULT-THEME&visualizationUrl=U2FsdGVkX1%2Btyu1tAfovEieshimr1kMCjLpUXj8Xj1Se6ZoskUOY9xy0WSJyoWvbaHR3C7efJLFsAYvknrfc4Ofb3zqo9bjWhhIUGdtgIp6bitruPIvShiqwMbLG05FK&datasetId=S2L2A&fromTime=2024-11-09T00:00:00.000Z&toTime=2024-11-09T23:59:59.999Z&layerId=2_TONEMAPPED_NATURAL_COLOR&demSource3D=%22MAPZEN%22
- Planetary Computer: https://planetarycomputer.microsoft.com/explore?c=167.8417%2C-77.5520&z=7.66&v=2&d=sentinel-2-l2a&m=cql%3A0bbe8c2e6820a52f6d134152bbbc4a3c&r=Natural+color&s=false%3A%3A100%3A%3Atrue&sr=desc&ae=0
```

We'll use `rioxarray` again to open the GeoTIFF files (using `overview_level=1` means
we can get a lower resolution version), and to mosaic the two image tiles together.

```{code-cell}
tile_58CEU = rioxarray.open_rasterio(
    filename="https://sentinel-cogs.s3.us-west-2.amazonaws.com/sentinel-s2-l2a-cogs/58/C/EU/2024/11/S2B_58CEU_20241109_0_L2A/TCI.tif",
    overview_level=1,
)
tile_58CEV = rioxarray.open_rasterio(
    filename="https://sentinel-cogs.s3.us-west-2.amazonaws.com/sentinel-s2-l2a-cogs/58/C/EV/2024/11/S2B_58CEV_20241109_0_L2A/TCI.tif",
    overview_level=1,
)

rgb_mosaic = rioxarray.merge.merge_arrays(dataarrays=[tile_58CEU, tile_58CEV])
rgb_image = rgb_mosaic.rio.reproject_match(match_data_array=dem_mosaic)
rgb_image
```
```{tip}
When working with DEM mosaics and optical imagery, carefully consider the size and resolution of the data. High-resolution DEMs combined with complex topographies can demand substantial computational resources for processing and visualization. A practical tip is to start with lower resolutions to experiment with and refine the scene geometry (e.g., azimuth, elevation, and perspective). Once you are satisfied with the visualization setup, switch to higher-resolution data for the final rendering. This approach helps optimize computational efficiency while maintaining the quality of your analysis.
```

# 3️⃣ Draping RGB image on 3D topography

```{code-cell}
fig = pygmt.Figure()
with pygmt.config(PS_PAGE_COLOR="#a9aba5"):
    fig.grdview(
        grid=dem_mosaic,  # DEM layer
        drapegrid=rgb_image,  # Sentinel-2 image layer
        surftype="i600",  # image draping with 600dpi resolution
        perspective=[170, 20],  # view azimuth and angle
        zscale="0.0005",  # vertical exaggeration
        shading=True,  # hillshading
        # frame="af",
    )
fig.show()
```

When setting the `zscale` for vertical exaggeration, choose a value that balances clarity and realism. For subtle topographies, higher exaggeration (e.g., smaller `zscale` values) can emphasize elevation differences, making features more visible. However, for steep terrains, lower exaggeration helps maintain a natural appearance. You may use `shading=True` to add hillshading, which enhances the 3D effect by simulating light and shadows, making terrain features easier to interpret. Experiment with both parameters to find the best combination for your dataset and visualization goals.

