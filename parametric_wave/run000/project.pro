;;==Declare project title
title = "Parametric Wave: run000"

;;==Determine number of plots
np = max([n_elements(plotStep),1])

;;==Declare transpose order
if n_elements(np) ne 0 then xyzt = (np gt 1) ? [1,0,2,3] : [1,0,2]

;;==Declare (untransposed) data ranges
rngs = {x: [0,grid.nx-1], $
        y: [0,grid.ny-1], $
        z: [0,grid.nz-1]}

;;==Set the project struct
prj = set_current_prj(data,rngs,grid, $
                      np=np, $
                      xyzt=xyzt, $
                      title=title)
;;==Free memory
delvar, rngs

;;==Set graphics keywords
kw = set_default_kw('den',prj=prj,/image,/colorbar)
prj['kw'] = kw
