;;==Declare project title
title = "Parametric Wave: run000"

;;==Declare data scaling values for some or all quantities
scale = dictionary('den1', 1e2, $
                   'phi', 1e3, $
                   'emag', 1e3)

;;==Determine number of plots
np = [1,max([n_elements(plotStep),1])]

;;==Declare transpose order
if n_elements(np) ne 0 then $
   xyzt = (max(np) gt 1) ? [1,0,2,3] : [1,0,2]

;;==Declare (untransposed) data ranges
rngs = {x: [0,grid.nx-1], $
        y: [0,grid.ny-1], $
        z: [0,grid.nz-1]}

;;==Set the project struct
prj = set_current_prj(data,rngs,grid, $
                      scale = scale, $
                      np = np, $
                      xyzt = xyzt, $
                      title = title)
;;==Free memory
delvar, rngs

;;==Set up the graphics data units
set_data_units, prj,units

;;==Set default graphics keywords
global = 1B
prj['kw'] = set_default_kw(prj.data.keys(),prj=prj,/image,/colorbar,global=global)

;;==Modify specific keywords for this project
nData = n_elements(dataName)
for id=0,nData-1 do $
   prj.kw[dataName[id]].image['xtitle'] = "Zonal [m]"
for id=0,nData-1 do $
   prj.kw[dataName[id]].image['ytitle'] = "Vertical [m]"
for id=0,nData-1 do $
   prj.kw[dataName[id]].image['title'] = "t = "+strcompress( $
   string(1e3*dt*plotStep,format='(f7.2)'), $
   /remove_all)+" ms"
for id=0,nData-1 do $
   prj.kw[dataName[id]].colorbar['global'] = global
