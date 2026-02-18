# Difference-of-Convex-functions-approach-for-neural-network
This repo constains the codes and data used for the experiments in the paper, 'Difference of Convex (DC) approach for neural network approximation with uniform loss function'.

\begin{enumerate}
    \item Two Lead ECG dataset (training set) from~\cite{UCRArchive2018}. This dataset contains 23~signal segments, each signal contains 83~recordings. The output (function value) is binary $\{0,1\}$. The goal is to separate between these two classes.
    \item Two Lead ECG dataset (test set) from~\cite{UCRArchive2018}. This dataset contains 1139~signal segments, each signal contains 83~recordings. The output (function value) is binary $\{0,1\}$. The goal is to separate between these two classes.
    \item Discretisation of $\Phi_1(x,y)=\sqrt{|x-0.5|+3|y|}$ (function with a deep minimum) on the hypercube, where $(x,y) \in [-1,1]\times[-1,1]$. % Function1
    The total number of discretisation points is~2500, the discretisation step is~0.05 along each direction. 
 \item   $\Phi_2(x,y)=\sin(5x-0.5)-\sqrt{|\cos(7y)|}$ (function with several shallow local minima) in the hypercube, where $(x,y) \in [-1,1]\times[-1,1]$. % Function2
    The total number of discretisation points is~2500, the discretisation step is~0.05 in each direction.      
\end{enumerate}
