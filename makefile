mpi = mpirun -n 6

location = ~/../../media/pranjal/90e75855-d78b-4861-a47d-760da42579bf/QE

pw = ${location}/qe-6.3/bin/pw.x
bands = ${location}/qe-6.3/bin/bands.x
fs = ${location}/qe-6.3/bin/fs.x
plotbands = ${location}/qe-6.3/bin/plotband.x
projwfc = ${location}/qe-6.3/bin/projwfc.x
dos = ${location}/qe-6.3/bin/dos.x

structure = SrRhO2
outdir = output/

all-bands: scf nscf bands plotbands

all-fermi: scf nscf fermi

scf: ${structure}.scf.in
	${mpi} ${pw}<${structure}.scf.in>${outdir}${structure}.scf.out

scf-singular: ${structure}.scf.in
	${pw}<${structure}.scf.in>${outdir}${structure}.scf.out

nscf: ${structure}.nscf.in
	${mpi} ${pw}<${structure}.nscf.in>${outdir}${structure}.nscf.out

bands: ${structure}.bands.in
	${mpi} ${pw}<${structure}.bands.in>${outdir}${structure}.bands.out

bands-singular: ${structure}.bands.in
	${pw}<${structure}.bands.in>${outdir}${structure}.bands.out

plotbands: band_bands plotband.in
	${mpi} ${plotbands}<plotband.in>${outdir}plotband.out

band_bands: bands.in
	${mpi} ${bands} -i bands.in>${outdir}bands.out

fermi-singular: fs.in
	${fs}<fs.in>${outdir}fs.out

fermi: fs.in
	${mpi} ${fs}<fs.in>${outdir}fs.out

nscf-singular: ${structure}.nscf.in
	${pw}<${structure}.nscf.in>${outdir}${structure}.nscf.out

kpdos: ${structure}.kpdos.in
	${mpi} ${projwfc}<${structure}.kpdos.in>${outdir}${structure}.kpdos.out

dos: ${structure}.dos.in
	${mpi} ${dos}<${structure}.dos.in>${outdir}${structure}.dos.out

pdos: ${structure}.pdos.in
	${mpi} ${projwfc}<${structure}.pdos.in>${outdir}${structure}.pdos.out

relax: ${structure}.relax.in
	${mpi} ${pw}<${structure}.relax.in>${outdir}${structure}.relax.out
