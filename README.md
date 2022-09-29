- 👋 Hi, I’m @zy-gdou
- 👀 I’m interested in CFD simulations with applications to oceanic and atmospheric dynamics using idealized numerical models scripted using MATLAB.
- 🌱 One of such idealized models is the surface quasi-geostrophic (SQG) model. This model can diagnose the 3D flow current using a single snapshot of the surface density perturbaiton (which is usually proportional to the sea surface temperature, SST). Modern satellite remote sensing of SST could reach high spatial resolution of ~1 km, thus the diagnosed flow field can resolve part of the submesoscales of a few km. The resolution is beyond the 1/4 degree of the commonly-used geostrophic current provided by AVISO. Another interesting feature of the SQG model is that the predicted flow could bear an abundance of small-scale structures, with filaments and vortices surviving for quite a long time. In contrast, in the two-dimensional (or Quasigeostrophic/QG) turbulence, the large-scale structures outlives the small ones. Therefore the SQG model is promising in explaining part of the generation of the submesoscale structures in the ocean.

"beta-SQG/" adds the $\beta$-effect into the classic SQG current. Here, one can explore the Rossby wave dynamics, the Rhines scales and stuff related to the $\beta$-effect in the context of the SQG dynamics. It should be noted that the Lagrangian-conserved quantity in the SQG flow is the surface buoyancy perturbation $b_s(x,y,t)$, intead of the absolute vorticity in QG counterpart. It should be noted that the $\beta$-effect represents a permannent gradient in the background buoyancy/density, which triggers Rossby waves without surprise.

However, the SQG model is still constrained by the assumption of small Rossby number. At submesoscales, the Rossby number is not necessarily small and nonlinear advectoin plays a significant role. In order to better capture the nonlinearity under a small Rossby number, two high-order (in terms of the Rossby number) variants of the SQG model are proposed: the SQG+1 model and the SSG model.

"SSG/" contains the code used for free-decaying SSG turbulence.



