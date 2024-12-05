**Tutorial 6** - Animations with GMT (extended)
-----------------------------------------------

Content
- Extension of "Tutorial 6 - Animations with GMT"

.. note::
  This tutorial is part of the AGU24 annual meeting GMT/PyGMT pre-conference workshop (PREWS9) **Mastering Geospatial Visualizations with GMT/PyGMT**

  * Website: https://www.generic-mapping-tools.org/agu24workshop
  * GitHub: https://github.com/GenericMappingTools/agu24workshop
  * Conference: https://agu.confex.com/agu/agu24/meetingapp.cgi/Session/226736

  History

  History

  * Author: `Federico Esteban <https://orcid.org/0000-0002-0641-7371>`_
  * Created: November-December 2024
  * Recommended version: `GMT 6.5.0 <https://docs.generic-mapping-tools.org/6.5>`_

  Fee free to play around with these code examples 🚀. In case you found any kind of error, just report it by `opening an issue <https://github.com/GenericMappingTools/agu24workshop/issues>`_ or `provide a fix via a pull request <https://github.com/GenericMappingTools/agu24workshop/pulls>`_. Please use the `GMT forum <https://forum.generic-mapping-tools.org/>`_ to ask questions.

3. Tutorial 2. Earthquakes
~~~~~~~~~~~~~~~~~~~~~~~~~~

Here I explain how to make an animation with appearing objects.
This is more complex and requires the use :gmt-module:`events` and :gmt-module:`movie` modules.
In this example, I create an animation showing the occurrences of earthquakes during the year 2018 (with one frame per day).
Note that the earthquakes are drawn as they occur and remain visible until the end of the animation.

.. ..  youtube:: rmPhIVzhIgY
..  youtube:: dbOjYqWzGi0
    :align: center
    :height: 400px
    :aspect: 2:1


.. |

For this tutorial I follow these steps:

#. Make image
#. Make master frame
#. Make draft animation
#. Make animation without enhancement
#. Make animation with enhancement


3.1. Goals of the Tutorial
==========================

- What is gmt :gmt-module:`events`.
- How to use a background script for a movie.
- How to enhance symbols with :gmt-module:`events`.


3.2 Make image
==============

In this step I plot a map of the earth with all the quakes from 2018.

     .. gmtplot::
        :height: 400 px

        gmt begin Earth png
            # Set parameters and position
            gmt basemap -Rg -JN14c -B+n
            # Plot relief grid
            gmt grdimage @earth_relief_06m -I
            # Create cpt for the earthquakes
            gmt makecpt -Cred,green,blue -T0,70,300,10000
            # Plot quakes
            gmt plot @quakes_2018.txt -SE- -C
        gmt end

.. admonition:: Technical Information

    - I use :gmt-module:`makecpt` to create a `CPT <https://docs.generic-mapping-tools.org/6.5/reference/cpts.html#of-colors-and-color-legends>`_ to color the earthquakes.
    - I used the earthquakes from the file `quakes_2018.txt <https://github.com/GenericMappingTools/gmtserver-admin/blob/master/cache/quakes_2018.txt>`_ which has 5 columns.

      ============== ========== ======== ================ ========================
       Longitude      Latitude   Depth    Magnitude (x50)          Date
      ============== ========== ======== ================ ========================
       46.4223        -38.9126     10        260           2018-01-02T02:16:18.11
       169.3488       -18.8355   242.77      260           2018-01-02T08:10:00.06
       ...
      ============== ========== ======== ================ ========================

    - Note that the input file has the columns sorted as will be required by the :gmt-module:`plot` and :gmt-module:`events` modules. It was also used for `animation 08 <https://docs.generic-mapping-tools.org/6.5//animations/anim08.html>`_.
      Check it to see how it was downloaded and processed.


3.3. Make master frame
======================

In this step I create the master frame of the animation similar to the previous image.


3.3.1. First attempt (first frame)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In this first attempt I create the first frame (``-Mf,png``) of the animation.


     .. gmtplot::
        :height: 400 px

        cat << 'EOF' > main.sh
        gmt begin
          # Set parameters and position
          gmt basemap -Rg -JN${MOVIE_WIDTH} -B+n -X0 -Y0
          # Create background map
          gmt grdimage @earth_relief_06m -I
          # Create cpt for the earthquakes
          gmt makecpt -Cred,green,blue -T0,70,300,10000
          gmt plot @quakes_2018.txt -SE- -C
        gmt end
        EOF

        gmt movie main.sh -NQuakes -Mf,png -Zs -V -C24cx12cx80 -T2018-01-01T/2018-12-31T/1d -Gblack \
        -Lc0 --FONT_TAG=18p,Helvetica,white --FORMAT_CLOCK_MAP=-


.. admonition:: Technical Information

  - I use ``-T2018-01-01T/2018-12-31T/1d`` to create a one-column data set with all days in 2018.
  - I use ``-Lc0`` to add a label with the first column (i.e. the dates).
  - **--FONT_TAG=18p,Helvetica,white**: This sets the font for the label.
  - **--FORMAT_CLOCK_MAP=-**: to NOT include the hours in the date and only plot year, month and day in the label.
  - I use a custom canvas of 24 x 12 cm with a resolution of 80 DPC (``-C24cx12cx80``).


.. Error::

  - The first frame contains all the quakes when none of them should be plotted. I must use :gmt-module:`events` instead.


3.3.2. The events module
^^^^^^^^^^^^^^^^^^^^^^^^

In the previous figure, I use the :gmt-module:`plot` module to draw the symbols. This results that the symbols appear on all frames.
However if I want to plot quakes as they unfold, I have to use the :gmt-module:`events` instead.


.. Important::

  - :gmt-module:`events` requires a time column in the input data and will use it and the animation time to determine when symbols should be plotted.
  - The ``-T`` is a required argument and is used to set the current plot time.


3.3.3. Second attempt (first frame with events)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Now, in this attempt I use :gmt-module:`events` with ``-T${MOVIE_COL0}`` to plot the quakes as dates progresses


     .. gmtplot::
        :height: 400 px

        cat << 'EOF' > main.sh
        gmt begin
          # Set parameters and position
          gmt basemap -Rg -JN${MOVIE_WIDTH} -B+n -X0 -Y0
          # Create background map
          gmt grdimage @earth_relief_06m -I
          # Create cpt for the earthquakes
          gmt makecpt -Cred,green,blue -T0,70,300,10000
          gmt events @quakes_2018.txt -SE- -C -T${MOVIE_COL0}
        gmt end
        EOF

        gmt movie main.sh -NQuakes -Mf,png -Zs -V -C24cx12cx80 -T2018-01-01T/2018-12-31T/1d -Gblack \
        -Lc0 --FONT_TAG=18p,Helvetica,white --FORMAT_CLOCK_MAP=-


.. Warning::
  The map shows NO earthquakes. This is expected because there are no quakes (in the data file) before January first.
  However, this could also be due to an error in the command.
  I must plot the frame from another date to see if the quakes appear.


3.3.4. Third attempt (last frame with events)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Now, I also plot the last frame (``-Ml``).

     .. gmtplot::
        :height: 400 px

        cat << 'EOF' > main.sh
        gmt begin
          # Set parameters and position
          gmt basemap -Rg -JN${MOVIE_WIDTH} -B+n -X0 -Y0
          # Create background map
          gmt grdimage @earth_relief_06m -I
          # Create cpt for the earthquakes
          gmt makecpt -Cred,green,blue -T0,70,300,10000
          gmt events @quakes_2018.txt -SE- -C -T${MOVIE_COL0}
        gmt end
        EOF

        gmt movie main.sh -NQuakes -Ml,png -Zs -V -C24cx12cx80 -T2018-01-01T/2018-12-31T/1d -Gblack \
        -Lc0 --FONT_TAG=18p,Helvetica,white --FORMAT_CLOCK_MAP=-



3.4. Make draft animation
=========================

In this step, we can make a draft animation. For this example, I recommend making a low quality (with 30 DPC) video to see if the quakes appear correctly.

3.4.1. First attempt
^^^^^^^^^^^^^^^^^^^^


    .. code-block:: bash

        cat << 'EOF' > main.sh
        gmt begin
          # Set parameters and position
          gmt basemap -Rg -JN${MOVIE_WIDTH} -B+n -X0 -Y0
          # Create background map
          gmt grdimage @earth_relief_06m -I
          # Create cpt for the earthquakes
          gmt makecpt -Cred,green,blue -T0,70,300,10000
          gmt events @quakes_2018.txt -SE- -C -T${MOVIE_COL0}
        gmt end
        EOF

        gmt movie main.sh -NQuakes -Ml,png -Zs -V -C24cx12cx30 -T2018-01-01T/2018-12-31T/1d -Gblack \
        -Lc0 --FONT_TAG=18p,Helvetica,white --FORMAT_CLOCK_MAP=- -Fmp4


..  youtube:: TH4moYCHRT8
    :align: center
    :height: 400px
    :aspect: 2:1


.. Warning::
  - The above script works well but it can be more efficient if a background script is used as well.


3.4.2. The background script
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Within :gmt-module:`movie` module, there is an optional background (`-Sb <https://docs.generic-mapping-tools.org/6.5/movie.html#sb>`_) script that it is used for two purposes:

#. Create files that will be needed by the main script to make the movie.
#. Make a static background plot that should form the background for all frames.

.. admonition:: Technical Information

  The background script is run only once.


3.4.3. Second attempt (with background script)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In this step, instead of creating just the main script as before, I now create both a background script and a main script.
The background script (``pre.sh``) is used to:

#. create a CPT file that will be used to color the quakes.
#. make a **static** worldwide background map.

.. Important::

  - The animation created is identical to the previous one.
  - The use of a background script allows the creation of the animation much faster because the CPT and the **static** background map will be created only once (instead of 365 times).
..

    .. code-block:: bash

        cat << 'EOF' > pre.sh
        gmt begin
          # Set parameters and position
          gmt basemap -Rg -JN${MOVIE_WIDTH} -X0 -Y0 -B+n
          # Create background map
          gmt grdimage @earth_relief_06m -I
          # Create cpt for the earthquakes
          gmt makecpt -Cred,green,blue -T0,70,300,10000 -H > quakes.cpt
        gmt end
        EOF

        cat << 'EOF' > main.sh
        gmt begin
          gmt basemap -Rg -JN${MOVIE_WIDTH} -X0 -Y0 -B+n
          gmt events @quakes_2018.txt -SE- -Cquakes.cpt -T${MOVIE_COL0}
        gmt end
        EOF

        gmt movie main.sh -Sbpre.sh -NQuakes -Ml,png -Zs -V -C24cx12x80 -T2018-01-01T/2018-12-31T/1d -Gblack \
        -Lc0 --FONT_TAG=18p,Helvetica,white --FORMAT_CLOCK_MAP=-


.. admonition:: Technical Information

  - For the CPT, I must use `-H <https://docs.generic-mapping-tools.org/latest/makecpt.html#h>`_ and give it a name, and then use that name in ``main.sh``.
  - I add ``-Sbpre.sh`` within the :gmt-module:`movie` module to use the background script.
  - I repeat the ``basemap`` command in the main and background scripts so both have the same positioning (i.e., ``-X`` and ``-Y``) and parameters (i.e. ``-R`` and ``-J``).


3.5. Make full animation
=========================

Now I make the final high-quality animation (i.e. 80 DPC).


    .. code-block:: bash

        cat << 'EOF' > pre.sh
        gmt begin
          # Create background map
          gmt grdimage @earth_relief_06m -I -JN${MOVIE_WIDTH} -Rg -X0 -Y0
          # Create cpt for the earthquakes
          gmt makecpt -Cred,green,blue -T0,70,300,10000 -H > quakes.cpt
        gmt end
        EOF

        cat << 'EOF' > main.sh
        gmt begin
          gmt basemap -Rg -JN${MOVIE_WIDTH} -X0 -Y0 -B+n
          gmt events @quakes_2018.txt -SE- -Cquakes.cpt -T${MOVIE_COL0}
        gmt end
        EOF

        gmt movie main.sh -Sbpre.sh -NQuakes -Ml,png -Zs -V -C24cx12cx80 -T2018-01-01T/2018-12-31T/1d -Gblack -Fmp4 \
        -Lc0 --FONT_TAG=18p,Helvetica,white --FORMAT_CLOCK_MAP=-


..  youtube:: dbOjYqWzGi0
    :align: center
    :height: 400px
    :aspect: 2:1

|

3.6. Make full animation with enhancement
=========================================

In the previous animation, the earthquakes appear but it is hard to see when they do it.
With :gmt-module:`events` it is possible to draw attention to the arrival of a new event.

3.6.1. How to enhance symbols with events
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The idea is to change the default behavior of the symbols to enhance their appearance as shown in the following video:

..  youtube:: 77a2XrfWsHM
    :align: center
    :height: 400px
    :aspect: 16:9


|

This can be done by using `-M <https://docs.generic-mapping-tools.org/6.5/events.html#m>`_ and `-E <https://docs.generic-mapping-tools.org/6.5/events.html#e>`_ arguments.
The -M arguments allows to temporarily change attributes of the symbol like:

- -Ms: Provide a factor to modify the size.
- -Mc: Provide a value to brighten (up to 1) or darken (up to -1) the `color intensity <https://docs.generic-mapping-tools.org/6.5/reference/colorspace.html#artificial-illumination>`_.
- -Mt: Transparency. Set a value between 100 (invisible) to 0 (opaque).

The duration of the temporary changes is controlled via the `-E <https://docs.generic-mapping-tools.org/6.5/events.html#e>`_ argument.

- -Er: rise phase. It takes place before the start of the event.
- -Ep: plateau phase. It takes place after the start of the event.
- -Ed: decay phase. It develops after the plateau phase. If the plateau phase does not occur, then it takes place after the start of the event.


.. Note::

   - For finite symbols there are also *normal* and *fade* phases.
   - It is also possible to change the data value with ``-Mv``.


3.6.2. Make full animation
^^^^^^^^^^^^^^^^^^^^^^^^^^

In this step I announce each quake by magnifying size and whitening the color for a little bit (during the rise phase).
Later the symbols return to their original properties during the decay phase.
The plateau phase is not used.


    .. code-block:: bash

        cat << 'EOF' > pre.sh
        gmt begin
          # Create background map
          gmt grdimage @earth_relief_06m -I -JN${MOVIE_WIDTH} -Rg -X0 -Y0
          # Create cpt for the earthquakes
          gmt makecpt -Cred,green,blue -T0,70,300,10000 -H > quakes.cpt
        gmt end
        EOF

        cat << 'EOF' > main.sh
        gmt begin
          gmt basemap -Rg -JN${MOVIE_WIDTH} -X0 -Y0 -B+n
          gmt events @quakes_2018.txt -SE- -Cquakes.cpt -T${MOVIE_COL0} -Es+r2+d6 -Ms5+c1 -Mi1+c0 -Mt+c0 --TIME_UNIT=d
        gmt end
        EOF

        gmt movie main.sh -Sbpre.sh -NQuakes -Ml,png -Zs -V -C24cx12cx80 -T2018-01-01T/2018-12-31T/1d -Gblack -Fmp4 \
        -Lc0 --FONT_TAG=18p,Helvetica,white --FORMAT_CLOCK_MAP=-


..  youtube:: rmPhIVzhIgY
    :align: center
    :height: 400px
    :aspect: 2:1


.. admonition:: Technical Information

  - \--TIME_UNIT=d: This sets that the values of -E are in days (d).
  - -Es+r2+d6: This sets the duration of the rise phase and the decay phase.
  - -Ms5+c1: modify the size. The size will increase 5 times during the rise phase and then reduce to the original size in the coda phase.
  - -Mt+c0: modify the transparency. The transparency will remain to 0 at the coda phase. This allows it to be seen after its occurrence.
  - -Mi1+c0: modify the intensity of the color. It gets lighter during the rise phase and then returns to its original color in the coda phase.


4. See also
~~~~~~~~~~~

- The paper about animations which include explanation and examples (`Wessel et al. 2024 <https://doi.org/10.1029/2024GC011545>`_).

- Check the :gmt-module:`movie` and :gmt-module:`events` modules documentation for full technical information.

- See the `GMT animation gallery <https://docs.generic-mapping-tools.org/6.5/animations.html>`_ for more examples.


5. References
~~~~~~~~~~~~~

- Wessel, P., Luis, J. F., Uieda, L., Scharroo, R., Wobbe, F., Smith, W. H. F., & Tian, D. (2019). The Generic Mapping Tools Version 6. Geochemistry, Geophysics, Geosystems, 20(11), 5556–5564. https://doi.org/10.1029/2019GC008515
- Wessel, P., Esteban, F., & Delaviel-Anger, G. (2024). The Generic Mapping Tools and animations for the masses. Geochemistry, Geophysics, Geosystems, 25, e2024GC011545. https://doi.org/10.1029/2024GC011545.
