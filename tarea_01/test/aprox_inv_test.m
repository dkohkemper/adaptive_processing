clc;
clear;
close('all');

addpath 'src';

matrix_a = [1 0 2; -1 5 0; 0 3 -9];
tolerance = 0.001;

matrix_a_inv = aprox_inv(matrix_a, tolerance)