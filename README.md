# Master's Research Project

## Abstract 
**Subject:** The use of Partial Least Squares (PLS) for a Deep Fundamental Factors regression.

**Supervisor:** Dr Matthew Dixon

**Original GitHub Repository**: https://github.com/mfrdixon/Deep_Fundamental_Factors

## Data
The data X.csv and Y.csv used in the main notebook can be downloaded from the original repository above.

The data folder contains a smaller Fundamental Factors dataset, the PLS datasets corresponding to specific percentages of variance explained and the pickle data to easily recreate the figures of the main notebook.

## Source Code
The conversion of the Fundamental Factors dataset to a PLS is done in the _src/compute_PLS.R_ script where we use the "pls" R library. In this script, we specify a percentage of variance explained that we want to obtain. This variance explained value is obtained by incrementing the number of components of the PLS.

The main code is situated in _src/PLS_DNN_vs_OLS.ipynb_, where we compare the performances of Deep Neural Network fed by PLS regressions of the Fundamental Factors, and OLS and Deep Neural Network fed directly by the Fundamental Factors.
