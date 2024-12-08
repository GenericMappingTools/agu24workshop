# Making animations
# Step 2. Make master frame.
# Step Goal: Make a master frame that looks identical to the first image.
# 2nd attempt. Fix the canvas


cat << 'EOF' > main.sh
gmt begin
	gmt grdimage @earth_relief_06m -I -JG0/0/13c -X0 -Y0
gmt end
EOF
gmt movie main.sh -NEarth -V -L+f14p,Helvetica-Bold,white -Gblack -C13cx13cx80 -T360 -M0,png