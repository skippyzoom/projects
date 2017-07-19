;+
; Simple line plots of theoretical initial profiles
; for quasineutral static dust project.
;-

;;==Background plasma density
n_0 = 1e10
;;==Dust charge state
Z_d = 1.0
;;==Coordinate
z = findgen(1000)/999
;;==Location of Guassian peak
z_0 = 0.5
;;==Guassian standard deviation
sigma = 0.2/(2*sqrt(2*alog(2)))
;;==Ratio of dust-to-ion density
alpha = 0.1
;;==Given dust profile
n_d = alpha*n0*exp(-0.5*((z-z_0)/sigma)^2)
;;==Analytic equilibrium ion profile
n_i = 0.5*Z_d*n_d* $
      (1+sqrt(1+(2*n_0/Z_d/n_d)^2))
;;==Electron profile from quasineutrality
n_e = n_i-Z_d*n_d

;;==Create plots
loadct, 39
plot, z,n_d,xstyle=1,yrange=[0,1.1*max([max(n_i,/nan),max(n_e,/nan),max(n_d,/nan)])]
oplot, z,n_i,color=80
oplot, z,n_e,color=240
