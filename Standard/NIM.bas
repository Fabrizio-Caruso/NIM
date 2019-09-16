1000 rem ==============================
1001 rem                              =
1002 rem           nimrod 64          =
1003 rem                              =
1004 rem          hmr project         =
1005 rem        progettohmr.it        =
1006 rem                              =
1007 rem ==============================
1008 rem
1100 rem strutture dati
1101 rem
1110 rem stato, val dec correnti
1111 dim w(4)
1120 rem val dec ipotesi di mossa
1121 dim m(4)
1130 rem val bin per valutaz mossa
1131 dim b(4,3)
1140 rem val xor per colonne
1141 dim x(3)
1150 rem ris valutaz mossa, 0 buona
1151 let r=1
1160 rem condiz di vittoria, 0 vinto
1161 let v=1
1170 rem tavolo di gioco per stampa
1171 dim z(4,7)
1180 rem inizializza rndgen
1181 rem randomize
1200 rem
1201 rem stampa tavolo di gioco vuoto
1210 gosub 6000
1300 rem
1301 rem scelta di chi inizia il gioco
1302 rem stabilendo la conf iniziale
1310 let k$="no": input "inizio io"; k$
1320 if k$="s" or k$="si" or k$="S" or k$="SI" then go to 1410
1330 print "bene, disponi tu le file"
1340 for i=0 to 3
1350 print "fila n.";i+1;: input w(i+1)
1360 if w(i+1)<1 or w(i+1)>7 then print "no!": goto 1350
1370 next i
1380 gosub 5000
1390 gosub 6000
1400 goto 1500
1410 print "come vuoi, ecco la mia disposizione..."
1420 gosub 8000
1430 gosub 4000
1440 gosub 6000
1450 goto 1800
1500 rem
1501 rem ciclo di gioco ===============
1502 rem
1503 rem 64 muove
1510 print "tocca a me..."
1511 rem generazione mosse
1520 for i=0 to 3: let m(i+1)=w(i+1): next i
1530 for i=0 to 3
1540 if w(i+1)=0 then go to 1610
1550 for j=1 to w(i+1)
1560 let m(i+1)=w(i+1)-j
1570 gosub 3000
1571 rem se r=0 buona, finisce
1580 if r=0 then let f=i+1: let q=j: goto 1700
1590 next j
1591 rem fine riga, ripristina
1600 let m(i+1)=w(i+1)
1610 next i
1611 rem nessuna buona, mossa a caso
1620 let f=int(rnd(1)*4)+1: if w(f)=0 then goto 1620
1630 let q=int(rnd(1)*w(f))+1: if q>5 then goto 1630
1640 print "mmh... ";
1700 rem dichiara mossa ed esegue
1710 print "levo "; q; " da "; f: gosub 4000
1720 let w(f)=w(f)-q: gosub 7000
1730 gosub 4000
1740 gosub 6000
1741 rem se v=0 vittoria 64, fine
1750 gosub 2000
1760 if v=0 then print "ho vinto!": goto 1950
1800 rem
1801 rem umano muove
1810 let f=0: let q=0: print "tocca a te, ";
1820 print "da quale fila?": input f
1830 if f<1 or f>4 then print "no!": goto 1820
1840 if w(f)=0 then print "no!": goto 1820
1850 print "quanti?": input q
1860 if q<1 or q>w(f) then print "no!": goto 1850
1870 let w(f)=w(f)-q: gosub 7000
1880 gosub 6000
1881 rem se v=0 vittoria umano, fine
1890 gosub 2000
1900 if v=0 then print "bravo, hai vinto!": goto 1950
1910 goto 1500
1911 rem fine ciclo di gioco ==========
1950 rem
1951 rem esci o rigioca
1960 input "vuoi rigiocare"; k$
1970 if k$="s" or k$="si" or k$="S" or k$="SI" then goto 1300
1980 print "alla prossima, ciao!"
1990 end
1991 rem fine programma ===============
1992 rem
1993 rem
1994 rem sottoprogrammi ===============
2000 rem
2001 rem calcola cond vittoria
2010 let v=0
2020 for i=0 to 3
2030 let v=v+w(i+1): next i
2040 return
3000 rem
3001 rem valutazione mossa
3010 for k=0 to 3
3020 let b(k+1,1) = m(k+1) and 1
3030 let b(k+1,2) =(m(k+1) and 2)/2
3040 let b(k+1,3) =(m(k+1) and 4)/4
3050 next k
3060 for k=0 to 2
3070 let x(k+1)=b(1,k+1)+b(2,k+1)+b(3,k+1)+b(4,k+1)
3080 next k
3090 let r=(x(3) and 1)+(x(2) and 1)+(x(1) and 1)
3100 return
4000 rem
4001 rem attesa
4010 for t=1 to 200: next t
4020 return
5000 rem
5001 rem genera z da w
5010 for j=0 to 3
5020 for i=0 to w(j+1)-1: let z(j+1,i+1)=1: next i
5030 next j
5050 return
6000 rem
6001 rem stampa tavolo di gioco
6010 rem cls
6015 print:print:print:print:print:print:print:print:print:print:print:print
6016 print:print:print:print:print:print:print:print:print:print:print:print
6020 print " nimrod 64 - hmr project 2017 "
6030 print
6040 for i=0 to 3
6050 print "          ";: print i+1;
6060 for j=0 to 6
6070 if z(i+1,j+1)=1 then print " x";
6080 if z(i+1,j+1)=0 then print " o";
6090 next j
6100 print: print
6110 next i
6120 print
6130 print " ============================== "
6140 return
7000 rem
7001 rem aggiorna z da f e q
7010 let rp=q
7020 for p=6 to 0 step -1
7030 if z(f,p+1)=0 then goto 7070
7040 if rp=0 then goto 7070
7050 let z(f,p+1)=0
7060 let rp=rp-1
7070 next p
7080 return
8000 rem
8001 rem seleziona disp. iniziale
8010 restore
8020 read dn
8030 let dd = int(rnd(1)*dn)
8040 if dd=0 then goto 8060
8050 for s=1 to dd*32: read tmp: next s
8060 for i=0 to 3
8070 for j=0 to 6
8080 read z(i+1,j+1):
8090 next j
8100 next i
8110 for i=0 to 3: read w(i+1): next i
8120 return
9000 rem
9001 rem dati disposizioni iniziali ===
9005 data 8
9010 data 1,1,1,1,0,0,0
9011 data 1,1,1,1,1,0,0
9012 data 1,1,1,1,1,1,0
9013 data 1,1,1,1,1,1,1
9014 data 4,5,6,7
9020 data 0,0,0,1,0,0,0
9021 data 0,0,1,1,1,0,0
9022 data 0,1,1,1,1,1,0
9023 data 1,1,1,1,1,1,1
9024 data 1,3,5,7
9030 data 1,1,1,1,1,1,1
9031 data 1,0,0,0,0,0,1
9032 data 1,0,0,0,0,0,1
9033 data 1,1,1,1,1,1,1
9034 data 7,2,2,7
9040 data 0,0,1,1,1,0,0
9041 data 0,1,1,1,1,1,0
9042 data 0,1,1,1,1,1,0
9043 data 0,0,1,1,1,0,0
9044 data 3,5,5,3
9050 data 1,1,1,0,0,1,1
9051 data 1,1,1,1,0,1,1
9052 data 1,1,0,1,1,1,1
9053 data 1,1,0,0,1,1,1
9054 data 5,6,6,5
9060 data 1,1,1,1,1,1,1
9061 data 1,1,1,1,1,1,1
9062 data 1,1,1,1,1,1,1
9063 data 1,1,1,1,1,1,1
9064 data 7,7,7,7
9070 data 1,1,1,0,1,1,1
9071 data 0,0,1,1,1,0,0
9072 data 0,0,1,1,1,0,0
9073 data 1,1,1,0,1,1,1
9074 data 6,3,3,6
9080 data 1,1,1,1,0,0,0
9081 data 0,1,1,1,1,0,0
9082 data 0,0,1,1,1,1,0
9083 data 0,0,0,1,1,1,1
9084 data 4,4,4,4
