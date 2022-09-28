## Plot scipt for binning and plotting the distributions from EPOCH
## simulation data
import numpy as np
import sdf
import sdf_helper as sh
import matplotlib as mpl
import matplotlib.pyplot as plt
import pylab as pl

#plt.rc('text', usetex=True)
#plt.rc('font', family='serif',size=18)
#plt.ion()
#plt.ioff()
#fig_w=9; fig_h=5; ## inches
#colorbar_padding=0.12

## Constants
c         =     299792458.      # m/s
pi        =     3.1415926535897932384626
q0        =     1.602176565e-19 # C
ev        =     q0 # J

m0        =     9.10938291e-31  # kg
m_e       =     m0              # kg
m_p       =     1.672621777e-27 # kg
m_n       =     1.6749286E-27   # kg
v0        =     2.99792458e8    # m/s^2
kb        =     1.3806488e-23   # J/K
mu0       =     4.0e-7*pi       # N/A^2
epsilon0  =     8.8541878176203899e-12 # F/m
h_planck  =     6.62606957e-34  # J s
wavelength=     1.0e-6
frequency =     v0*2*pi/wavelength

exunit    =     m0*v0*frequency/q0
bxunit    =     m0*frequency/q0
denunit   =     frequency**2*epsilon0*m0/q0**2

j_to_kev  =  6.241509e+15 # direct convertion J -> keV   
j_to_mev  =  6.241509e+12 # direct convertion J -> keV   

## Indicator which species to plot
s='n'

Nx=400                          # Number of x grid points
xlim=np.array([0.9,1.5])        # Range in x [um]
Np=200                          # Number of p grid points
plim=np.array([-.25,1.0])*.02   # Range in p [mc]


sdffile = '/lustre/rz/dbertini/collisions/data/0001.sdf'
data    = sdf.read(sdffile, dict=True)
print('Data fields present in "' + sdffile + '":')
print(data.keys())

## Get neutrons kinematics
vx_n = data['Particles/Vx/neutron'].data
vy_n = data['Particles/Vy/neutron'].data
vz_n = data['Particles/Vz/neutron'].data

px_n = data['Particles/Px/neutron'].data
py_n = data['Particles/Py/neutron'].data
pz_n = data['Particles/Pz/neutron'].data
w_n  = data['Particles/Weight/neutron'].data
ek_n = data['Particles/Ek/neutron'].data

print(ek_n*j_to_mev)

ek_n = ek_n*j_to_mev

fig, ax =  plt.subplots()
plt.hist(ek_n, weights=w_n, bins=200, density=True, histtype='step', facecolor='g', alpha=0.75)
pl.title('D(d,n)He Neutrons Energy, Epoch 4.18, Te_D = 5 keV')    
plt.xlim(2.0,3.0)
plt.xlabel('Energy [MeV]')
plt.ylabel('dY/dE [arb.]')
plt.savefig("e_neutrons.png")
