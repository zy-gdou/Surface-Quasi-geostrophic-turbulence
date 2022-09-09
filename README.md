- 👋 Hi, I’m @zy-gdou
- 👀 I’m interested in CFD simulations with applications to oceanic and atmospheric dynamics using idealized numerical models scripted using MATLAB.
- 🌱 One of such idealized models is the surface quasi-geostrophic (SQG) model. One advantage of this model is that it allows oceanographers to diagnose the 3D flow current from a single snapshot of the surface density perturbaiton (or sea surface temperature, SST). Modern satellite remote sensing could provide detailed surface information to a high-spatial resolution (~1 km), thus openning an acesss to diagnose the upper ocean current down to the horizontal scale of a few km. Thus the SQG-diagnosed flow field processes a higher spatial resolution than the 1/4 degree in geostrophic current provided by AVISO. Another interesting feature of the SQG flow is an abundance of small-scale structures: filaments and vortices are allowed to survive for quite a long time in the SQG current. This is contrary to the case of two-dimensional(Quasigeostrophic, QG) turbulence, where the large-scale structures outlives the small ones. Thus, the SQG model is promising in explaining the generation  of the submesoscale structures in the ocean.

"beta-SQG/" adds the $\beta$-effect in the classic SQG current. There one can explore the Rossby wave dynamics, the Rhines scales and stuff related to the $\beta$-effect.

One should note that the SQG model is still constrained by the assumption of small Rossby number. At submesoscales, the Rossby number is not necessarily small and the nonlinear advectoin  plays a significant role. In order to better resolve the nonlinearity but given a small Rossby number, two high-order (in terms of the Rossby number) variants of the SQG model are proposed: the SQG+1 model and the SSG model.
"SSG/" contains the codes used for a free-decaying SSG turbulence.



