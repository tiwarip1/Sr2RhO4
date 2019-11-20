mpi = mpirun -n 6
pw = ~/Desktop/QE/qe-6.3/bin/pw.x
bands = ~/Desktop/QE/qe-6.3/bin/bands.x
fs = ~/Desktop/QE/qe-6.3/bin/fs.x
plotbands = ~/Desktop/QE/qe-6.3/bin/plotband.x
projwfc = ~/Desktop/QE/qe-6.3/bin/projwfc.x
dos = ~/Desktop/QE/qe-6.3/bin/dos.x

structure = Sr2RhO4
outdir = output/

all-bands: scf nscf bands plotbands

all-fermi: scf nscf fermi

scf: ${structure}.scf.in
	${mpi} ${pw}<${structure}.scf.in>${outdir}${structure}.scf.out

scf-singular: UPt3.scf.in
	${pw}<UPt3.scf.in>UPt3.scf.out

nscf: UPt3.nscf.in
	${mpi} ${pw}<UPt3.nscf.in>UPt3.nscf.out

bands: UPt3.bands.in
	${mpi} ${pw}<UPt3.bands.in>UPt3.bands.out

bands-singular: UPt3.bands.in
	${pw}<UPt3.bands.in>UPt3.bands.out

plotbands: band_bands plotband.in
	${mpi} ${plotbands}<plotband.in>plotband.out

band_bands: bands.in
	${mpi} ${bands} -i bands.in>bands.out

fermi-singular: fs.in
	${fs}<fs.in>fs.out

fermi: fs.in
	${mpi} ${fs}<fs.in>fs.out

nscf-singular:
	${pw}<UPt3.nscf.in>UPt3.nscf.out

kpdos: UPt3.kpdos.in
	${mpi} ${projwfc}<UPt3.kpdos.in>UPt3.kpdos.out

dos: UPt3.dos.in
	${mpi} ${dos}<UPt3.dos.in>UPt3.dos.out

pdos: UPt3.pdos.in
	${mpi} ${projwfc}<UPt3.pdos.in>UPt3.pdos.out

relax: UPt3.relax.in
	${mpi} ${pw}<UPt3.relax.in>UPt3.relax.out
