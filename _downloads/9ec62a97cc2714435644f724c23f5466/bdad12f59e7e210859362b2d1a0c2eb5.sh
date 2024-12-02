gmt begin Canvas png
  gmt basemap -Jx0.5c -R0/24/0/13.5 -B+glightgreen+t"16x9 format" --FONT_TITLE=24,Helvetica
  gmt basemap -Ba5f1g5+u" cm" -BWeSn
        echo 24 cm by 13.5 cm | gmt text -F+f24p+cMC -Gwhite
gmt end