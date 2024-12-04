# Mastering Geospatial Visualizations with GMT/PyGMT

Welcome to the AGU24 [GMT](https://docs.generic-mapping-tools.org/6.5)/
[PyGMT](https://www.pygmt.org/v0.13.0) workshop 🥳! This Jupyter book 📖 contains
tutorials for making maps 🗺️ and animations 🎦

::::::{grid} 1 1 3 3
:gutter: 1
:padding: 1


:::::{grid-item}
::::{grid} 1 1 1 1
:gutter: 1

:::{grid-item-card} Tutorial 1 - First figure + Subplots / layout
:img-top: _images/fd70248f75b8b37ee54b3135f77705f98c6d8489eb18b6910184b447d0f0638d.png
:link: ./tut01_firstfigure.html
by [Jing-Hui Tong](https://orcid.org/0009-0002-7195-3071)
+++
{bdg-primary}`pygmt`
{bdg-primary-line}`coast`
{bdg-primary-line}`colorbar`
{bdg-primary-line}`grdimage`
{bdg-primary-line}`makecpt`
{bdg-primary-line}`subplot`
{bdg-secondary-line}`earth_relief`
{bdg-secondary-line}`earth_age`
:::

:::{grid-item-card} Tutorial 2 - Integration with the Scientific Python Ecosystem: Pandas / GeoPandas
:img-top: _images/7f18327908c8dd210197cc51845e45a933f356b9fd12bd029a4a8cbda080eb2b.png
:link: ./tut02_spe_pd_gpd.html
by [Yvonne Fröhlich](https://orcid.org/0000-0002-8566-0619)
+++
{bdg-primary}`pygmt`
{bdg-primary-line}`histogram`
{bdg-primary-line}`legend`
{bdg-primary-line}`plot`
{bdg-secondary-line}`japan_quakes`
{bdg-success}`pandas`
{bdg-success}`geopandas`
{bdg-success-line}`choropleth map`
:::

::::
:::::


:::::{grid-item}
::::{grid} 1 1 1 1
:gutter: 1

:::{grid-item-card} Tutorial 3 - Integration with the Scientific Python Ecosystem: Xarray (grids)
:img-top: _images/a18fcb026fb0d0c83360f2b8382a360e552dd50db6aa2db5311259bf5223d3a2.png
:link: ./tut03_spe_xarray.html
by [Max Jones](https://orcid.org/0000-0003-0180-8928)
+++
{bdg-primary}`pygmt`
{bdg-primary-line}`config`
{bdg-primary-line}`grdgradient`
{bdg-primary-line}`which`
{bdg-secondary-line}`earth_relief`
{bdg-success}`xarray`
{bdg-success-line}`temperature`
{bdg-success-line}`CMIP6`
:::

:::{grid-item-card} Tutorial 4 - Geophysics (Seismology)
:img-top: https://github.com/user-attachments/assets/37d94581-b9e9-4dec-a021-07c1b58c132a
:link: ./tut04_geophysics.html
by [Jing-Hui Tong](https://orcid.org/0009-0002-7195-3071)
and [Yvonne Fröhlich](https://orcid.org/0000-0002-8566-0619)
+++
{bdg-primary}`pygmt`
{bdg-primary-line}`grdcontour`
{bdg-primary-line}`grdinfo`
{bdg-primary-line}`grdtrack`
{bdg-primary-line}`meca`
{bdg-primary-line}`project`
{bdg-primary-line}`text`
{bdg-primary-line}`xyz2grd`
{bdg-success}`numpy`
{bdg-success}`pandas`
:::

::::
:::::


:::::{grid-item}
::::{grid} 1 1 1 1
:gutter: 1

:::{grid-item-card} Tutorial 5 - Topography (Planetary Maps / 3-D Antarctic Maps)
:img-top: _images/1dfddce0ff606bd7dc3a175aedbd2fc4bde3aeadfadfd339eb30ce1903d049f9.png
:link: ./tut05_topography.html
by [Wei Ji Leong](https://orcid.org/0000-0003-2354-1988)
and [André Belém](https://orcid.org/0000-0002-8865-6180)
+++
{bdg-primary}`pygmt`
{bdg-primary-line}`grdview`
{bdg-secondary-line}`mars_relief`
{bdg-success}`rioxarray`
{bdg-success-line}`Sentinel-2`
{bdg-success-line}`DEM`
:::

:::{grid-item-card} Tutorial 6 - Animations
:img-top: _images/5847818951ca8fbc9b86a6f2c67389b6.png
:link: ./tut06_animation.html
by [Federico Esteban](https://orcid.org/0000-0002-0641-7371)
+++
{bdg-primary}`gmt`
{bdg-primary-line}`events`
{bdg-primary-line}`movie`
{bdg-secondary-line}`earth_relief`
{bdg-secondary-line}`quakes_2018`
{bdg-success}`bash`
:::

::::
:::::


::::::


Each tutorial is rendered on this website for easy viewing 👀, but they are all Jupyter
notebooks designed to be ran interactively 💫. See the instructions below on how you can
start running the tutorials in no time! 🚀


# 🌠 Quickstart

To run these notebooks in an interactive Jupyter session online, 🖱️ click on the button
below to launch on regular
[Binder](https://mybinder.readthedocs.io/en/latest/index.html).

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/GenericMappingTools/agu24workshop/main)

Alternatively, you can go to a specific tutorial page, hover over the rocket 🚀 icon on
the top right, and click 'Binder'.

# 💻 Running the notebooks locally

If you prefer to run the 🧑‍🏫 tutorials with a local installation of GMT/PyGMT, then
follow along! For this AGU24 workshop, we recommend creating a virtual conda environment
and installing the C and 🐍 Python libraries inside.

:::{tip} For users comfortable with using `git`, feel free to ⬇️ download or clone the
repository containing the workshop materials directly using
`git clone https://github.com/GenericMappingTools/agu24workshop.git`
:::

Here's the instructions to install the `agu24workshop` environment:

1. Ensure that you have the
   [`conda`](https://docs.conda.io/projects/conda/en/latest/user-guide/index.html)
   package manager installed (e.g. via
   [`miniconda`](https://docs.anaconda.com/miniconda) or
   [Anaconda](https://www.anaconda.com/download)). You can also use
   [`mamba`](https://mamba.readthedocs.io/en/stable/installation/mamba-installation.html)
   which tends to be a ⚡ faster alternative.

2. Make a folder called 'agu24workshop'. This will be where you will put all the Jupyter
   notebooks and data files 🗃️ used in the workshop.

3. Download a copy of the 'environment.yml' file which contains a 📄 list of
   dependencies required to run the tutorials in this workshop. Get it at
   https://github.com/GenericMappingTools/agu24workshop/blob/main/environment.yml.

4. Run the following commands on the 🧑‍💻 command-line to create the virtual environment

    ```bash
    cd /path/to/agu24workshop
    conda env create --name agu24workshop --file environment.yml
    ```

5. Once the installation is completed 🏁, launch
   [Jupyter Lab](https://jupyterlab.readthedocs.io) as follows:

    ```bash
    conda activate agu24workshop
    jupyter lab
    ```

   This should open up a page in your default browser. If not, you can click and open
   the 🔗 link that says `http://localhost:8888/lab?token=...` in your command-line
   terminal and this will will take you to the Jupyter Lab page.

6. Download the Jupyter notebook(s) you want to run (e.g.
   https://www.generic-mapping-tools.org/agu24workshop/tut01_firstfigure.html) using
   either the download button on the ↗️ top right (select '.ipynb') or from GitHub at
   https://github.com/GenericMappingTools/agu24workshop/tree/main/book. Make sure to put
   the *.ipynb file(s) inside of the 'agu24workshop' folder.

7. Open the Jupyter notebook in the left-pane file browser, e.g. by 🖱️ double-clicking
   on `first-figure.ipynb`. You are now ready to run through the course materials 🎉!

```{note}
If you're intending to use GMT/PyGMT in another project outside of this course, please
follow the official installation instructions at:

- https://docs.generic-mapping-tools.org/latest/install.html
- https://www.pygmt.org/latest/install.html
```
