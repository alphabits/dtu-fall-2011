===================================
02610 Optimization and data fitting
===================================


This is my notes for the course 02610 Optimization and data fitting.


------
Week 1
------

Problem 1
---------
This was a very basic exercise. A little matlab code was produced

.. literalinclude:: week-1/problem_1_1.m
    :language: matlab

Problem 2
---------
In this problem 4 different polynomials are given. They should be plotted along with their first and second derivative. Also a very basic exercise

.. literalinclude:: week-1/problem_2_1.m
    :language: matlab


------
Week 3
------

Exercise 2.1
------------
In this exercise the gradient and Hessian of the Rosenbrock function should be calculated. To make the calculation general the Rosenbrock function is given by (where :math:`a>0`)

.. math::

    f(x) = a(x_2 - x_1^2)^2 + (1 - x_1)^2

The gradient is found as

.. math::

    \nabla f(x) = \begin{bmatrix}
        - 4 a x_1 (x_2 - x_1^2) - 2 (1 - x_1) \\
          2 a (x_2 - x_1^2)
    \end{bmatrix}

And the hessian as

.. math::

    \nabla^2 f(x) = \begin{bmatrix}
        -4ax_2 + 12ax_1^2 + 2 & -4ax_1 \\
        -4ax_1 & 2a
    \end{bmatrix}

Exercise 3.1
------------
In this exercise the steepest decent and Newton algorithms using backtracking line search should be implemented. In the steepest decent method the search direction is given by

.. math:: 

    p_k = - \nabla f_K

And in the Newton method the direction is given by

.. math::

    p_k = -\nabla^2 f_k^{-1}\nabla f_k

Since the only real difference between the two algorithms is the search direction, both algorithms can be implemented in one method. It is shown below

.. literalinclude:: week-3/linesearch.m
    :language: matlab

Newton and steepest decent can then be implemented as

.. literalinclude:: week-3/steepestdecent.m
    :language: matlab

.. literalinclude:: week-3/newton.m
    :language: matlab

Both depends on the backtracking algorithm, that is given below

.. literalinclude:: week-3/backtracking.m
    :language: matlab
