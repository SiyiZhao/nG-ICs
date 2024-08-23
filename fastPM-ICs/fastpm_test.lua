-- parameter file
------ Size of the simulation---------- 

-- For Testing
--nc = 1024
nc = 512
--nc = 256
--nc = 128
boxsize = 1000.0
--boxsize = 500.0
--boxsize = 250.0

-------- Time Sequence ----
-- linspace: Uniform time steps in a
-- time_step = linspace(0.025, 1.0, 39)
-- logspace: Uniform time steps in loga
--time_step = linspace(0.01, 1.0, 100)
--time_step = linspace(0.01, 1.0, 1)
time_step = {0.02}

output_redshifts= {49}  -- redshifts of output

-- Cosmology --
omega_m = 0.3099
h       = 0.67742

------- Initial power spectrum --------
-- See libfastpm/pngaussian.c for documentation
-- Amplitude of primordial power spectrum at pivot scale

scalar_amp = 2.1064e-9   -- same as scalar_amp in CAMB
-- Pivot scale k_pivot in 1/Mpc
scalar_pivot = 0.05  -- same as pivot_scalar in CAMB
-- Primordial spectral index n_s
scalar_spectral_index = 0.96822 -- same as scalar_spectral_index in CAMB

sigma8 = 0.808992
--
-- Start with a power spectrum file
-- Linear power spectrum at z=0: k P(k) in Mpc/h units
-- Must be compatible with the Cosmology parameter
read_powerspectrum = "/home/siyizhao/SeeCosmology/data/pkl_z0/fastpm.dat"

f_nl_type = 'local'
--f_nl = 0.
f_nl = 100.0
kmax_primordial_over_knyquist = 0.666
ic_kernel_type = 'green'


random_seed = 42
--inverted_ic = true
--remove_cosmic_variance = true


-------- Approximation Method ---------------
force_mode = "fastpm"

pm_nc_factor = 2            -- Particle Mesh grid pm_nc_factor*nc per dimension in the beginning
change_pm = 0.2            -- time(scaling factor) when the pm_nc_factor is changed, range from 0 to 1

np_alloc_factor= 4.0      -- Amount of memory allocated for particle
                          -- AGA: This parameter can be decreased up to ~1.5 or so 
                          --to reduce the memory footprint of the code
loglevel=0                 -- 0=verbose increase value to reduce output msgs

--za = true
-------- Output ---------------

-- Dark matter particle outputs (all particles)
write_snapshot= "/hscratch/siyizhao/ICs/fastpm/ics/test"
-- 1d power spectrum (raw), without shotnoise correction
write_powerspectrum = "/hscratch/siyizhao/ICs/fastpm/ics/test_pk"
--write_noisek = "/home/adrian/UNIT_PNG/FastPM_mod/output_tests/snaps/noisek"
--write_noise = "/home/adrian/UNIT_PNG/FastPM_mod/output_tests/snaps/noise"
