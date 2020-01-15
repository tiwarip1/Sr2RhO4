import numpy as np
import matplotlib.pyplot as plt
from os import listdir
from os.path import isfile, join
import string

onlyfiles = [f for f in listdir('../') if isfile(join('../', f))]

fermi = 10.4183

for files in onlyfiles:
	if 'SrRhO2.pdos_atm#11(Rh)_wfc#5(d)' in files:
		df = np.loadtxt('../'+files,skiprows=1)
		
		fig=plt.figure(figsize=[20,10])
		plt.plot(df[:,0]-fermi,df[:,2],color='k',label='d$_z$')
		plt.plot(df[:,0]-fermi,df[:,3]+df[:,4],color='b',label='d$_{yz}$+d$_{zx}$')
		plt.plot(df[:,0]-fermi,df[:,5],color='r',label='d$_{x^2-y^2}$')
		plt.plot(df[:,0]-fermi,df[:,6],color='y',label='d$_{xy}$')
		plt.ylabel('States/eV')
		plt.xlabel('Energy (eV)')
		plt.legend(loc='upper left')

		ax = plt.gca()
		ax.set_ylim(0,1.6)
		ax.set_xlim(-2.5,4)

		ax.axvline(x=0,linestyle='--',color='r')

		files = files.translate(str.maketrans('', '', string.punctuation))
		files = files.translate(str.maketrans('', '', '._atom#wfc'))
		files = files[10:]
		if files[0].isnumeric():
			files=files[1:]
		print(files)

		ax.set_title(files)
		ax.spines['right'].set_visible(False)
		ax.spines['top'].set_visible(False)	

		fig.savefig('pdos_plots/{}'.format(files),dpi=400)
		fig.clf()
		plt.close()
		del fig
