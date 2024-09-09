load dry2;

z2e = dry2(1:500)
z2p = dry2(501:1000)
sys1 = tfest(z2e, 1)
sys2 = tfest(z2e, 2)
arx221 = arx(z2e, [2 2 1])
armx2221 = armax(z2e, [2 2 2 1])
arx441 = arx(z2e, [4 4 1])
compare(z2p, sys1, sys2, arx221, arx441, armx2221)