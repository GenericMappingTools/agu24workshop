# Making animations
# Step 3. Make draft animation
# Step Goal: See that the video file is created properly.
#            See that the frames are changing as expected.
# 2nd attempt. Use parameter

cat << 'EOF' > main.sh
gmt begin
	gmt grdimage @earth_relief_06m -I -JG-${MOVIE_FRAME}/0/${MOVIE_WIDTH} -Y0 -X0
gmt end
EOF
gmt movie main.sh -NEarth -V -L+f14p,Helvetica-Bold,white -Gblack -C13cx13cx30 -T10  -M0,png  -Fmp4 -Zs