# Compression Of Room Impulse Responses Using Eigensystem Realization Algorithm

## About
Matlab implementation of the application of Eigensystem Realization Algorithm (ERA) to Room Impulse Responses (RIRs).

## Abstract
Room Impulse Response (RIR) compression is a growing necessity in the audio field. Capturing the acoustic response of large spaces, such as cathedral halls, requires a large amount of stored data. For this reason we explore the use of Eigensystem Realization Algorithm (ERA) in the context of RIR compression. ERA extrapolates a state-space linear model from the original signal, which can be compressed using the Singular Value Decomposition. Choosing how many Hankel Singular Values will be used in the creation of the state-space model we can parametrically adjust the amount of information to discard. We analyzed the efficiency and quality of this compression for SISO and MIMO cases with an higher order microphone and a MIMO case with a uniform linear array. The results, measured through the Signal to Distortion Ratio and with a listening test show a poor performance in the quality of the compression.


## Contents

```
.
├── README.md
├── code
│   ├── lib
│   ├── savedData
│   ├── MIMO_eval.m
│   ├── MIMO_testEra.m
│   ├── plot_EDC.m
│   ├── plot_EDR.m
│   ├── plot_script.m
│   ├── SISO_eval.m
│   ├── SISO_testEra.m
│   ├── test_speech.m
│   ├── ULA_eval.m
│   ├── ULA_testEra.m
├── data
│   │   ├── audio
│   │   ├── images
```

- `code`: folder with the source code.
    - `lib`: folder with utilities for computing ERA, preprocessing, EDR.
    - `savedData`: folder with data of MSE and SDR saved for plot.
    - `MIMO_eval.m`: RIR matrix (MIMO) is preprocessed and compress through ERA with a range of values of 'r'. For each level of compression, MSE and SDR are saved.
    - `MIMO_testEra.m`: RIR matrix (MIMO) is preprocessed and compressed through ERA with set values of 'r' and for each level of compression the resulting compressed RIR is saved. 
    - `plot_EDC.m`: script for plotting the Energy Decay Curve of original and compressed RIRs.
    - `plot_EDR.m`: script for plotting the Energy Decay Relief of the original RIR and each saved compressed RIR.
    - `plot_script.m`: script for plotting MSE and SDR.
    - `SISO_eval.m`: RIR (SISO) is preprocessed and compress through ERA with a range of values of 'r'. For each level of compression, MSE and SDR are saved.
    - `SISO_testEra.m`: RIR (SISO) is preprocessed and compressed through ERA with set values of 'r' and for each level of compression the resulting compressed RIR is saved.
    - `test_speech.m`: script for applying the saved RIRs to some speech signals.
    - `ULA_eval.m`: RIR matrix (MIMO ULA) is preprocessed and compress through ERA with a range of values of 'r'. For each level of compression, MSE and SDR are saved.
    - `ULA_testEra.m`: RIR matrix (MIMO ULA) is preprocessed and compressed through ERA with set values of 'r' and for each level of compression the resulting compressed RIR is saved. 
- `data`: folder with audio data and output images.

# lib

This folder contains utilities for computing ERA, the preprocessing of the signals and the Energy Decay and Relief plot.

## Contents

```
.
├── EDR.m
├── ERA.m
├── rir_preprocessing.m
├── rir_preprocessing_MIMO.m
├── t30.m
```

- `EDR.m`: a function for the calculation of the EDR of a signal.
- `ERA.m`: a function for applying ERA. It takes as input the pre-processed RIR and outputs the 4 SSM matrices and the HSVs.
- `rir_preprocessing.m`: a function for preprocessing a RIR array. It returns the preprocessed array, the ground truth used for comparisons and the initial delay.
- `rir_preprocessing_MIMO.m`:  a function for preprocessing an LxM RIR matrix. It returns the preprocessed matrix, the ground truth matrix used for comparisons and the matrix of initial delays.
- `t30.m`: a function used to estimate the t30 cutoff sample. It allows also to plot the EDC of the signal.

# audio

This folder contains audio data, in particular the original RIRs, the compressed RIRs and the test audio used for the listening test.

## Contents

```
.
├── original_RIR
├── RIR_comp
├── test_audio
│   ├── female 
│   ├── male
```

- `original_RIR`: folder with the RIRs used from the original dataset [HOMULA-RIR](https://arxiv.org/abs/2402.13896)
- `RIR_comp`: folder with the RIRs compressed with ERA
- `test_audio`: folder with the audio files obtained from convolution of original and compressed RIRs with a speech signal
    - `female`: folder with audio files obtained from convolution with female speech
    - `male`: folder with audio files obtained from convolution with male speech
