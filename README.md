# Difference-of-Convex-functions-approach-for-neural-network
This repo constains the codes and data used for the experiments in the paper, 'Difference of Convex (DC) approach for neural network approximation with uniform loss function'.

There are 4 data sets:
1. Two Lead ECG dataset (training set) from [1]. 
2. Two Lead ECG dataset (test set) from [1]. 
3. Discretisation of $\Phi_1(x,y)=\sqrt{|x-0.5|+3|y|}$ (function with a deep minimum) on the hypercube, where $(x,y) \in [-1,1]\times[-1,1]$. 
4. $\Phi_2(x,y)=\sin(5x-0.5)-\sqrt{|\cos(7y)|}$ (function with several shallow local minima) in the hypercube, where $(x,y) \in [-1,1]\times[-1,1]$.

The main component of DCA is based on solving large scale linear programming problems. In our experiments, we use MATLAB R2024b and where possible, we use the ``default settings''. 
In the case of neural networks, we use Python 3.10.15 to run our experiments together with the package, PyTorch 2.9.1 to develop simple neural networks. 


# Reference
[1] Dau, H. A., Keogh, E., Kamgar, K., Yeh, C. -C. M., Zhu, Y., Gharghabi, S., Ratanamahatana, C. A., Yanping, Hu, B., Begum, N., Bagnall, A., Mueen, A., Batista, G., Hexagon-ML. (2018) The UCR Time Series Classification Archive, https: //www.cs.ucr.edu/~eamonn/time_series_data_2018/
