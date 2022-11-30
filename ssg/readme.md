This is a numerical model for the surface semi-geostrophic turbulence formulated by 
> Ragone and Badin 2016: A study of surface semi-geostrophic turbulence: Freely decaying dynamics. J. Fluid Mech., 792, 740–774, https://doi.org/10.1017/jfm.2016.116. 
The variables used in the model and in the reference paper are non-dimensional; they are nondimensionalized by the characteristic scales defined in 
1. def_char_scales.m
2. def_grid.m deinfes the 2D horizontal grid $(X,Y)$ for the geostrophic coordinate system. The governning equations are discretiszed in the $(X,Y)$ grid using a Fourier-based spectral method, however the nonlinear advection term takes Arakawa's 9-points scheme which conserves both kinetic energy and enstrophy(in this case $b_s^2$). The Arakawa nonlinear term is formulated in
3. Jac_Arakawa.m
4. def_ini_bs.m defines the initial field for the surface buoyancy perturbation $b_s(X,Y)$ whose spectral sturcture is kept the same as eq.4.2 in the reference paper and an arbitary (nondimensional) amplitude could be assigned.
5. def_2irds_cutoff_filter.m defines a spectral filter in the $(k_X,k_Y)$ wavenumber space which suppress the numerical instability
6. phi_from_bs.m calcualtes the SSG streamfunction in the $(X,Y)$ domain using the surface buoyancy $b_s(X,Y)$ after each time step
7. coorTrans.m is used only for postprocessing. It transfers the field in $(X,Y)$ domian back to the physical domian, where a fixed-point iteration method is employed(see Appendix B in the reference paper for details of the method)
