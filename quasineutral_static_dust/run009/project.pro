;;==Declare project title
title = "Quasineutral Static Dust: run009"

;;==Determine number of plots
np = max([n_elements(plotStep),1])

;;==Declare transpose order
if n_elements(np) ne 0 then xyzt = (np gt 1) ? [0,1,2,3] : [0,1,2]

;;==Declare (untransposed) data ranges
rngs = {x: [0,grid.nx-1], $
        y: [grid.ny/2-grid.ny/4,grid.ny/2+grid.ny/4-1], $
        z: [0,grid.nz-1]}

;;==Set the project struct
prj = set_current_prj(data,rngs,grid, $
                      np=np, $
                      xyzt=xyzt, $
                      title=title)
;;==Free memory
delvar, rngs
