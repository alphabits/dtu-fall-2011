02418 Statistical modelling
===========================


------
Week 1
------

Read chapter 1 and 2. Results of exercises.

Exercise 1.3
------------
Fit the model

.. math::

    \log(t) = c_1 + c_2\log(a)

Where :math:`t` is running time and :math:`a` is age. A simple linear fit is calculated

.. literalinclude:: week-1/opg_1_3.R
    :language: r

And the results are

.. literalinclude:: week-1/opg_1_3.out

Exercise 1.4
------------
The model :math:`y=a+bx+cx^2` should be fitted to a data set consisting of pairs of year :math:`x`, winning speed :math:`y` in a car race. The R code used is

.. literalinclude:: week-1/opg_1_4.R
    :language: r

Giving the output

.. literalinclude:: week-1/opg_1_4.out

Exercise 2.3
------------
Four different types of fat have been used to make doughnuts. The amount of fat absorbed during cooking have been recorded. Six measurements per fat type. A one-way anova is calculated to see whether a difference between the fat types can be detected or not. The R code

.. literalinclude:: week-1/opg_2_3.R
    :language: r

And the results

.. literalinclude:: week-1/opg_2_3.out

Exercise 2.10
-------------
Three varieties of potatoes have been planted on four different locations. For each location, varity pair three measurements of the yields are measured and a two way anova with interactions is calculated. The R code

.. literalinclude:: week-1/opg_2_10.R
    :language: r

And the results

.. literalinclude:: week-1/opg_2_10.out


------
Week 2
------

Exercise 3.4
------------
R code

.. literalinclude:: week-2/exercise-3-4.R
    :language: r

Result

.. literalinclude:: week-2/exercise-3-4.out

Exercise 4.1
------------
R code

.. literalinclude:: week-2/exercise-4-1.R
    :language: r

Result

.. literalinclude:: week-2/exercise-4-1.out

Exercise 4.3/4
--------------
In these exercises a simple one-way anova model and a two way anova without interactions must be expressed as a linear regression model. The R code

.. literalinclude:: week-2/exercise-4-3.R
    :language: r

results in

.. literalinclude:: week-2/exercise-4-3.out


------
Week 3
------

Exercise 6.1
------------
In this exercise a regression model for fuel prices must be found using 

    * Forward selection

    * Backward selection

    * Stepwise selection


