# Mastering Geospatial Visualizations with GMT/PyGMT

## Welcome to the AGU24 GMT/PyGMT workshop 🥳

This Jupyter book 📖 contains [GMT](https://docs.generic-mapping-tools.org/6.5) and
[PyGMT](https://www.pygmt.org/v0.13.0) tutorials for producing maps 🗺️ and doing
geospatial data processing 🌐

::::{grid} 3

:::{grid-item-card} Tutorial 1 - First figure + Subplots / layout
:img-top: _images/d9e3a5b11d774ff087afeb95b8bfd3e7974afe8b1e8f51d12a4736419cdc6974.png
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
:img-top: _images/3844bc04880f1c0b3a90179cd789cde13ad0d25aff650d43fd9d840114d063fe.png
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

:::{grid-item-card} Tutorial 3 - Integration with the Scientific Python Ecosystem: Xarray (grids)
:img-top: _images/b3e45577786a5769fb54bb550f7032f3a73adc8289e08523d052827560bf3b0e.png
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

:::{grid-item-card} Tutorial 5 - Topography (Planetary Maps / 3-D Antarctic Maps)
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
   https://www.generic-mapping-tools.org/agu24workshop/first-figure.html) using either
   the download button on the ↗️ top right (select '.ipynb') or from GitHub at
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
