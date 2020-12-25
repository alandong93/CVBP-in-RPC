# CVBP-in-RPC
Contains data and code for the manuscript "Complex-Valued Braess Paradox in Resistive Pulse Cytometry"

## Contents
- MPS
  - directory containing code and data for metal pad sensing experiment in Figure 1
- Circuits
  - directory containing data for circuit experiment in Figure 2
- COMSOL
  - directory contining COMSOL model and automation scripts for simulation experiments in Figures 4 and 5
  
### MPS
- V_raw.mat
  - workspace containing raw voltage measurements recorded by AD2 from instrumentation amplifier
- I_raw.mat
  - workspace containing current obtained by taking raw voltage measurements recorded by AD2 from transimpedance amplifier and dividing by gain resistor value
- iq_demod.m
  - function for performing In-phase/Quadrature (IQ) demodulation
- demod_script.m
  - script for performing IQ demodulation on raw voltage and current and dividing to obtain impedance at multiple frequencies
- G100_P200_G100_MDA_50mbar_4sines_4Vpp.mat
  - workspace containing demodulated impedance at multiple frequencies, produced by demod_script.m
- joint_wavelet_clean.m
  - function for performing joint wavelet denoising of multiple impedance signals
- plot_figure_1.m
  - script for performing extra filtering and denoising of impedance signals for plotting

### Circuits
- bridge_without_e.csv
  - CSV containing impedance data (Z_open) for circuit in Figure 2(c)
- bridge_with_e.csv
  - CSV containing impedance data (Z_closed) for circuit in Figure 2(c)
- plot_bridge.m
  - script for plotting impedance data in Figure 2(c)
- RRC_without_e.csv
  - CSV containing impedance data (Z_open) for circuit in Figure 2(d)
- RRC_with_e.csv
  - CSV containing impedance data (Z_closed) for circuit in Figure 2(d)
- plot_RRC.m
  - script for plotting impedance data in Figure 2(d)

### COMSOL
- G100P200G100.mph
  - COMSOL model for simulated MPS microchannel
- simulate_cell_sizes.m
  - script to automate simulations with varying cell size
- Z_mat_G100P200G100_cell_sizes.mat
  - workspace containing simulated impedance data, produced by simulate_cell_sizes.m
- simulate_pad_lengths.m
  - script to automate simulations with varying metal pad lengths (must run twice: once with cell outside sensing region, once with cell above metal pad; additionally, number of frequencies simulated differs from other scripts so the .mph file must be updated correspondingly)
- Z_mat_G100P200G100_pad_lengths_xout.mat
  - workspace containing simulated impedance data (cell outside sensing region), produced by simulate_pad_lengths.m
- Z_mat_G100P200G100_pad_lengths_xpad.mat
  - workspace containing simulated impedance data (cell above metal pad), produced by simulate_pad_lengths.m
- simulate_transit.m
  - script to automate simulations with varying cell position
- Z_mat_G100P200G100_transit.mat
  - workspace containing simulated impedance data, produced by simulate_transit.m
