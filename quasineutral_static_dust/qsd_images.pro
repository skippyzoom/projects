;+
; Part of quasineutral static dust project
;-
@load_eppic_params
;; nSteps = 4
;; timestep = nout*((ntMax/nSteps)*(1+lindgen(nSteps)))
timestep = nout*lindgen(ntMax)
dataName = ['den1','phi']
dataType = ['ph5','ph5']
data = load_eppic_data(dataName,dataType,timestep=timestep)

;; imgData = reform(data.den1[*,grid.ny/2-grid.ny/4:grid.ny/2+grid.ny/4-1,0,*])
;; @den.prm
;; multi_image, imgData,kw_image=kw_image,kw_colorbar=kw_colorbar,name='den.pdf'
;; imgData = reform(data.phi[*,grid.ny/2-grid.ny/4:grid.ny/2+grid.ny/4-1,0,*])
;; @phi.prm
;; multi_image, imgData,kw_image=kw_image,kw_colorbar=kw_colorbar,name='phi.pdf'
;; ;; multi_image, reform(imgData),rgb_table=5,/colorbar

;; emag = calc_emag(data.phi,phiSW=5.0,/add_E0,/verbose)
;; imgData = reform(emag[*,grid.ny/2-grid.ny/4:grid.ny/2+grid.ny/4-1,0,*])
;; @emag.prm
;; multi_image, imgData,kw_image=kw_image,kw_colorbar=kw_colorbar,name='emag_full.pdf'
;; emag = calc_emag(data.phi,phiSW=5.0,/verbose)
;; imgData = reform(emag[*,grid.ny/2-grid.ny/4:grid.ny/2+grid.ny/4-1,0,*])
;; @emag.prm
;; multi_image, imgData,kw_image=kw_image,kw_colorbar=kw_colorbar,name='emag_pert.pdf'

;; @scratch
if n_elements(emag) eq 0 then emag = calc_emag(data.phi,phiSW=5.0,/verbose)
nTimestep = n_elements(timestep)
emag_rms = fltarr(nTimestep)
for it=0,nTimestep-1 do emag_rms[it] = rms(emag[*,*,*,it])
E0_mag = Ey0_external           ;(Won't be true in general)
xVals = dt*timestep
nxVals = n_elements(xVals)
;; yVals = alog10((emag_rms/E0_mag)^2)
;; yVals = alog((emag_rms/E0_mag)^2)
yVals = alog(emag_rms/E0_mag)
;; yVals = (emag_rms/E0_mag)^2
nyVals = n_elements(yVals)
plt = plot(xVals,yVals, $
           axis_style=2, $
           ;; position=[0.10,0.10,0.40,0.40], $
           ;; aspect_ratio=1, $
           xstyle=1, $
           xtitle='Time [s]', $
           ;; ytitle='$ln(\delta E^2/E_0^2)$', $
           ytitle='$ln(\delta E/E_0)$', $
           ;; yrange=[-6,-3], $
           ;; title='Average Perturbation Electric Field Energy', $
           yrange=[-2.8,-1.8], $
           title='Average Perturbation Electric Field', $
           /buffer)
;; ax = plt.axes
;; ax[1].log = 1B

fitInds = indgen(nxVals/4) + nxVals/8
nFit = n_elements(fitInds)
coeff = linfit(xVals[fitInds],yVals[fitInds])
yFit = coeff[0] + coeff[1]*xVals
opl = plot(xVals[fitInds],yFit[fitInds]-0.1,'k--',/overplot)
slopeStr = string(coeff[1],format='(f5.3)')
slopeStr = "$\gamma$ = "+strcompress(slopeStr,/remove_all)+" $s^{-1}$"
txtAngle = 4.5
txt = text(xVals[fitInds[nFit/2]],yFit[fitInds[nFit/2]]-0.20,slopeStr, $
           orientation=txtAngle,/data, $
           alignment=0.5, $
           font_name="Times")

fitInds = indgen(nxVals/4) + 3*nxVals/4 - nxVals/8
nFit = n_elements(fitInds)
coeff = linfit(xVals[fitInds],yVals[fitInds])
yFit = coeff[0] + coeff[1]*xVals
opl = plot(xVals[fitInds],yFit[fitInds]-0.1,'k--',/overplot)
slopeStr = string(coeff[1],format='(f5.3)')
slopeStr = "$\gamma$ = "+strcompress(slopeStr,/remove_all)+" $s^{-1}$"
txtAngle = 30.0
txt = text(xVals[fitInds[nFit/2]],yFit[fitInds[nFit/2]]-0.20,slopeStr, $
           orientation=txtAngle,/data, $
           alignment=0.5, $
           font_name="Times")

pltName = 'E-rms_power.pdf'
print, "Saving ",pltName,"..."
plt.save, pltName
plt.close
print, "Finished"
