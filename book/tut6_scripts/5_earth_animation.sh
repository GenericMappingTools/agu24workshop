# Making animations
# Step 4. Make full animation
# Step Goal: Get the final animation.
# Increase number of frames (-T) and movie quality (-C).


cat << 'EOF' > main.sh
gmt begin
	gmt grdimage @earth_relief_06m -I -JG-${MOVIE_FRAME}/0/${MOVIE_WIDTH} -Y0 -X0
gmt end
EOF
gmt movie main.sh -NEarth -V -L+f14p,Helvetica-Bold,white -Gblack -C13cx13cx80 -T360 -M0,png  -Fmp4 -Zs