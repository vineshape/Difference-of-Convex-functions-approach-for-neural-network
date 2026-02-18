# Difference-of-Convex-functions-approach-for-neural-network
This repo constains the codes and data used for the experiments in the paper, 'Difference of Convex (DC) approach for neural network approximation with uniform loss function'.

There are 4 data sets:
1. Two Lead ECG dataset (training set) from~\cite{UCRArchive2018}. 
2. Two Lead ECG dataset (test set) from~\cite{UCRArchive2018}. 
3. Discretisation of $\Phi_1(x,y)=\sqrt{|x-0.5|+3|y|}$ (function with a deep minimum) on the hypercube, where $(x,y) \in [-1,1]\times[-1,1]$. 
4. $\Phi_2(x,y)=\sin(5x-0.5)-\sqrt{|\cos(7y)|}$ (function with several shallow local minima) in the hypercube, where $(x,y) \in [-1,1]\times[-1,1]$.
