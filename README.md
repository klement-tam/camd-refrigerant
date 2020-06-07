# camd-refrigerant

Algorithm formulated on GAMS which optimally identifies 10 alternative refrigerants which can potentially level or even surpass the performance of a widely used HFC refrigerant, R134a (tetrafluoroethane).

## Description of project
The CAMD method was used to forecast promising molecular designs which can replace R134a. This involves solutions which meet specific target properties while satisfying molecular property specifications.

The problem is of a mixed integer nonlinear programming (MINLP) formulation, as decision variables comprise of both binary variables on whether to use certain functional groups, and continuous variables on constraints such as pressure and temperature. The nonlinearity arises from the objective function and some constraints. Globally optimal solutions were found by implementing the proposed algorithm using the BARON solver (accessed via the GAMS modelling tool). Global optimization is used to ensure that the very best solutions are found within the astronomically vast possibilities of combinatorial molecular designs. 

10 unique alternative refrigerants were attained by using integer cuts, starting from the most optimal solution.

## Usage of code
### Changing of parameters
Parameters can be varied on Lines 165-170 of the code depending on design conditions.

### Number of solutions
If more than 10 unique solutions are required, you can change the set of the integer cut in line 354 of the code. 

## Report
Detailed explanation of the mathematical formulation and the results can be found in "written_report". 

## Authors
* Klement Tam
* Iylia Bin Ismail

## License
Running of the code requires a paid GAMS license. This project was GAMS-licensed under Imperial College London.  

## Acknowledgements 
Scientific reports were used as referenced in "written_report".
