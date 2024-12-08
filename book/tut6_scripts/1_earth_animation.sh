# Making animations
# Step 2. Make master frame.
# Step Goal: Make a master frame that looks identical to the first image.
# 1st attempt.


cat << 'EOF' > main.sh
gmt begin
	gmt grdimage @earth_relief_06m -I -JG0/0/13c
gmt end
EOF
gmt movie main.sh -NEarth -V -L+f14p,Helvetica-Bold,white -Gblack -Chd         -T360 -M0,png